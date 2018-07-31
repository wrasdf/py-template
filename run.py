import subprocess

def exec_sh(cmd):
    output = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)
    return str(output.strip(), 'utf-8')

NAMESPACES = [
    {"ns": "cash-in", "slug": "cash-in"},
    {"ns": "cash-out", "slug": "cash-out"},
    {"ns": "collaboration", "slug": "collab"},
    {"ns": "common-ledger-migrations", "slug": "clm"},
    {"ns": "data", "slug": "data"},
    {"ns": "forms-engine", "slug": "fe"},
    {"ns": "foundations", "slug": "fnd"},
    {"ns": "gm-digital", "slug": "gm-digital"},
    {"ns": "helios", "slug": "helios"},
    {"ns": "identity-and-security", "slug": "ids"},
    {"ns": "ledger-and-banking", "slug": "lb"},
    {"ns": "partner-workflows", "slug": "pwf"},
    {"ns": "payroll", "slug": "payroll"},
    {"ns": "platform-enablement", "slug": "pe"},
    {"ns": "platform-reliability", "slug": "pr"},
    {"ns": "platform-services", "slug": "ps"},
    {"ns": "sales-and-billing", "slug": "sb"},
    {"ns": "tax", "slug": "tax"},
    {"ns": "training", "slug": "train"},
    {"ns": "workpapers", "slug": "wp"},
    {"ns": "arl", "slug": "arl"}
]

TEXT_FILE = open("url.txt", "w")
for namespace in NAMESPACES:
    TEXT_FILE.write("./bin/deploy europa-stg {0}".format(namespace["ns"]))
    TEXT_FILE.write("\n")

for namespace in NAMESPACES:
    TEXT_FILE.write("./bin/gen_secrets {0} {1}".format(namespace["ns"], namespace["slug"]))
    TEXT_FILE.write("\n")

TEXT_FILE.close()
