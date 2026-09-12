"""Run the meaningful library regression suite into a NEW output directory."""
import argparse
from datetime import datetime
import json
from pathlib import Path
import shutil
import subprocess

import pymupdf as fitz
from verify import ROOT, verify, check_frozen


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--typst', default=shutil.which('typst'))
    parser.add_argument('--output', default=str(ROOT / 'builds' / ('tests-' + datetime.now().strftime('%Y%m%d-%H%M%S-%f'))))
    args = parser.parse_args()
    if not args.typst:
        parser.error('Typst not on PATH; provide --typst path/to/typst.exe')
    out = Path(args.output).resolve()
    out.mkdir(parents=True, exist_ok=False)
    results = []

    def compile_case(name, source, inputs=None, error=None):
        pdf = out / (name + '.pdf')
        command = [args.typst, 'compile', '--root', str(ROOT), '--font-path', str(ROOT / 'fonts')]
        for key, value in (inputs or {}).items():
            command.extend(['--input', key + '=' + value])
        command.extend([str(ROOT / source), str(pdf)])
        result = subprocess.run(command, capture_output=True, text=True)
        (out / (name + '.log')).write_text(result.stderr, encoding='utf-8')
        if error:
            assert result.returncode != 0 and error in result.stderr, (name, result.stderr)
        else:
            assert result.returncode == 0, (name, result.stderr)
        results.append({'case': name, 'passed': True})
        return pdf

    check_frozen()
    skills = compile_case('skills', 'tests/fixtures/skills.typ')
    assert verify(skills, pages=1, output=out / 'skills-check')['passed']
    with fitz.open(skills) as doc:
        text = ' '.join(doc[0].get_text().split())
        for phrase in ['Professional Skills', 'Technical Skills', 'Three columns', 'Navigation', 'Plain bullet', 'Third']:
            assert text.count(phrase) == 1, phrase
    engineer = compile_case('engineer', 'examples/engineer.typ')
    result = verify(engineer, ROOT / 'reference/Marine-Engineer-CV-v11.pdf', output=out / 'exact')
    assert result['passed'], result
    hidden = compile_case('engineer-hidden', 'examples/engineer.typ', {'vessel-durations': 'false'})
    with fitz.open(engineer) as a, fitz.open(hidden) as b:
        assert len(a) == len(b) == 2
        data = json.loads((ROOT / 'content/engineer-example.json').read_text())
        names = [s['name'] for c in data['companies'] for g in c['groups'] for s in g['ships']]
        names += ['Second Engineer', 'Third Engineer', 'Fourth Engineer', 'Engineering Cadet']
        for pa, pb in zip(a, b):
            for name in names:
                assert pa.search_for(name) == pb.search_for(name), name
        assert '8 months' not in ' '.join(p.get_text() for p in b)
    classic = compile_case('captain', 'examples/captain.typ')
    silver = compile_case('captain-silver', 'examples/captain-silver.typ')
    for pdf in [hidden, classic, silver]:
        assert verify(pdf, output=out / (pdf.stem + '-check'))['passed']
    with fitz.open(classic) as a, fitz.open(silver) as b:
        assert [' '.join(p.get_text().split()) for p in a] == [' '.join(p.get_text().split()) for p in b]
        assert 'Engineer' not in ''.join(p.get_text() for p in a)
    compile_case('data-valid', 'tests/fixtures/data.typ')
    for mode, message in [('missing-visible', 'Visible vessel durations'), ('mismatch', 'does not match'), ('negative', 'non-negative integer')]:
        compile_case('data-' + mode, 'tests/fixtures/data.typ', {'case': mode}, error=message)
    for mode in ['normal', 'no-portrait', 'no-contact']:
        compile_case('hero-' + mode, 'tests/fixtures/components.typ', {'case': mode})
    for mode in ['long-name', 'long-email']:
        compile_case('hero-' + mode, 'tests/fixtures/components.typ', {'case': mode}, error='exceeds')
    for mode in ['missing-months', 'optional', 'long-vessel']:
        pdf = compile_case('options-' + mode, 'tests/fixtures/options.typ', {'case': mode})
        assert verify(pdf, output=out / ('options-' + mode + '-check'))['passed']
    long_hidden = compile_case('long-hidden', 'tests/fixtures/options.typ', {'case': 'long-vessel', 'times': 'false'})
    with fitz.open(out / 'options-long-vessel.pdf') as a, fitz.open(long_hidden) as b:
        for pa, pb in zip(a, b):
            for token in ['MV Aurora', 'MV Caspian', 'Second Engineer']:
                assert pa.search_for(token) == pb.search_for(token), token
    three = compile_case('three-pages', 'tests/fixtures/pagination.typ')
    assert verify(three, pages=3, output=out / 'three-check')['passed']
    with fitz.open(three) as doc:
        text = ' '.join(' '.join(p.get_text().split()) for p in doc)
        assert 'Northline Marine (continued)' in text
        assert '13 years 6 months' in text and text.count('TOTAL EXPERIENCE') == 1
        assert 'TOTAL EXPERIENCE' in doc[2].get_text()
        for i in range(8):
            assert text.count('MV Test Vessel ' + str(i + 1)) == 1
    compile_case('overflow', 'tests/fixtures/pagination.typ', {'case': 'overflow'}, error='Content overflow')
    compile_case('duplicate', 'tests/fixtures/pagination.typ', {'case': 'duplicate'}, error='each vessel row once')
    certs = compile_case('certificate-continuation', 'tests/fixtures/certificate-continuation.typ')
    with fitz.open(certs) as doc:
        assert len(doc) == 2
        assert all('Scope / record' in p.get_text() for p in doc)
    check_frozen()
    report = {'passed': True, 'cases': results, 'exact_reference': result, 'output': str(out)}
    (out / 'report.json').write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(f'PASS: {len(results)} compilation cases plus PDF/data/layout assertions. Evidence: {out}')


if __name__ == '__main__':
    main()
