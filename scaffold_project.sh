#!/usr/bin/env bash
#
# scaffold_project.sh
# ----------------------------------------------------------------------
# Creates a standard product/project folder structure under ~/PROJECTNAME
# with a README.md template inside every folder.
#
# Usage:
#   ./scaffold_project.sh                 # interactive prompt for name,
#                                         # creates per-folder READMEs
#   ./scaffold_project.sh -n MyProduct    # non-interactive, name passed in
#   ./scaffold_project.sh --no-folder-readmes
#                                         # only the root README.md is
#                                         # created; per-folder READMEs
#                                         # are skipped
#   ./scaffold_project.sh -h | --help
# ----------------------------------------------------------------------

set -euo pipefail

# ---------- defaults ----------
PROJECT_NAME=""
CREATE_FOLDER_READMES=true

# ---------- arg parsing ----------
print_usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  -n, --name NAME           Project name (folder created at ~/NAME).
                            If omitted, you will be prompted.
      --no-folder-readmes   Do not create README.md in each subfolder.
                            Only the root README.md is created.
  -h, --help                Show this help and exit.
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -n|--name)
            PROJECT_NAME="${2:-}"
            shift 2
            ;;
        --no-folder-readmes)
            CREATE_FOLDER_READMES=false
            shift
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo "Unknown argument: $1" >&2
            print_usage
            exit 1
            ;;
    esac
done

# ---------- prompt if needed ----------
if [[ -z "$PROJECT_NAME" ]]; then
    read -r -p "Enter project name (folder will be created at ~/<name>): " PROJECT_NAME
fi

# Trim whitespace
PROJECT_NAME="$(echo "$PROJECT_NAME" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

if [[ -z "$PROJECT_NAME" ]]; then
    echo "ERROR: Project name cannot be empty." >&2
    exit 1
fi

# Reject anything that's not safe in a folder name
if [[ ! "$PROJECT_NAME" =~ ^[A-Za-z0-9._-]+$ ]]; then
    echo "ERROR: Project name may only contain letters, numbers, dot, underscore, hyphen." >&2
    exit 1
fi

PROJECT_ROOT="$HOME/$PROJECT_NAME"

if [[ -e "$PROJECT_ROOT" ]]; then
    echo "ERROR: $PROJECT_ROOT already exists. Aborting to avoid overwrite." >&2
    exit 1
fi

echo "Creating project structure at: $PROJECT_ROOT"
mkdir -p "$PROJECT_ROOT"

# ---------- folder list with descriptions ----------
# Format: "relative/path|Short description used inside that folder's README"
FOLDERS=(
"00_admin|Project administration: charter, governance, meetings, status reports, contracts, and budget tracking."
"00_admin/charter|Project charter, vision statement, mission, scope, success criteria, and approvals."
"00_admin/governance|Steering committee membership, decision logs, RACI matrix, and escalation paths."
"00_admin/meetings|Meeting agendas, minutes, action items, and recordings."
"00_admin/status_reports|Weekly and monthly status reports for leadership and stakeholders."
"00_admin/contracts|Master service agreements (MSAs), statements of work (SOWs), NDAs, vendor agreements."
"00_admin/budget|Budget forecasts, actual spend, purchase orders, invoices, and variance analysis."

"01_planning|Roadmaps, requirements, backlog, risk management, and resource planning."
"01_planning/roadmap|Product roadmap, release plan, milestone calendar, and themes."
"01_planning/requirements|PRD, BRD, FRD, user stories, acceptance criteria, and traceability matrix."
"01_planning/backlog|Epics, stories, prioritization frameworks (RICE, MoSCoW), grooming notes."
"01_planning/risks|Risk register, mitigation plans, issue log, and assumption tracking."
"01_planning/schedule|Gantt charts, sprint plans, release timelines, and critical-path analysis."
"01_planning/resource_plan|Staffing plan, capacity modeling, allocation, and skills inventory."

"02_research|Market, competitive, customer, and analytics research that informs product decisions."
"02_research/market_research|TAM/SAM/SOM analysis, industry reports, market sizing, and trend research."
"02_research/competitive_analysis|Competitor matrices, feature comparisons, win/loss analysis, positioning maps."
"02_research/customer_research|Customer interviews, surveys, personas, jobs-to-be-done (JTBD) artifacts."
"02_research/user_testing|Usability studies, A/B test plans and results, session recordings, findings reports."
"02_research/analytics|Data analyses, BI dashboards, KPI definitions, and instrumentation plans."

"03_design|UX, UI, and accessibility design artifacts."
"03_design/ux|User experience artifacts: research-driven design, flows, prototypes."
"03_design/ux/wireframes|Low-fidelity wireframes, sketches, and conceptual layouts."
"03_design/ux/user_flows|User journey maps, task flows, and interaction diagrams."
"03_design/ux/information_architecture|Sitemaps, navigation models, content hierarchies, taxonomies."
"03_design/ux/prototypes|Interactive prototypes (Figma, Axure, etc.) and click-through demos."
"03_design/ui|Visual design: high-fidelity mockups, design system, exportable assets."
"03_design/ui/mockups|High-fidelity mockups and visual comps for review and approval."
"03_design/ui/design_system|Design tokens, components, patterns, and the system documentation."
"03_design/ui/assets|Icons, illustrations, exports, and shared visual assets."
"03_design/accessibility|WCAG audits, accessibility reviews, remediation plans, and compliance evidence."

"04_engineering|Architecture, APIs, data models, security, infrastructure, and technical debt."
"04_engineering/architecture|System diagrams, architecture decision records (ADRs), technical specifications."
"04_engineering/api_specs|OpenAPI/Swagger specs, integration documentation, contract definitions."
"04_engineering/data|Database schemas, ERDs, data dictionaries, migration plans."
"04_engineering/security|Threat models, security reviews, pen test reports, vulnerability tracking."
"04_engineering/infrastructure|Cloud configuration, infrastructure-as-code (IaC), deployment topology, environments."
"04_engineering/technical_debt|Known issues, refactor plans, deprecation schedules."

"05_qa|Test plans, cases, results, defect tracking, and user acceptance testing."
"05_qa/test_plans|Master test plans, scope, strategy, entry/exit criteria."
"05_qa/test_cases|Detailed test cases organized by feature, module, or user story."
"05_qa/test_results|Test execution results, evidence, and pass/fail summaries."
"05_qa/defects|Bug reports, triage logs, defect metrics."
"05_qa/uat|User acceptance test artifacts: scripts, sign-offs, feedback."

"06_marketing|Marketing strategy, brand, content, campaigns, SEO/SEM, events, and PR."
"06_marketing/strategy|Go-to-market plan, positioning, messaging framework, value props."
"06_marketing/branding|Brand identity assets and guidelines."
"06_marketing/branding/logo|Primary, secondary, and variant logos; source files (AI, SVG); exports (PNG, JPG)."
"06_marketing/branding/styles|Brand style guide: color palette, typography, imagery rules, layout grids."
"06_marketing/branding/voice_tone|Brand voice and tone guidelines, copy do's and don'ts, sample messaging."
"06_marketing/branding/templates|Branded templates: letterhead, decks, social posts, email signatures."
"06_marketing/content|Long-form and short-form content assets."
"06_marketing/content/blog|Blog post drafts, published articles, editorial calendar."
"06_marketing/content/whitepapers|Whitepapers, ebooks, and long-form gated content."
"06_marketing/content/case_studies|Customer case studies, success stories, testimonials."
"06_marketing/content/video|Video scripts, storyboards, raw footage, final cuts."
"06_marketing/content/social_media|Social posts, calendars, channel plans, analytics."
"06_marketing/campaigns|Campaign briefs, calendars, creative, and performance reports."
"06_marketing/seo_sem|Keyword research, on-page SEO audits, paid search plans, performance data."
"06_marketing/events|Trade shows, webinars, conferences: planning, materials, lead capture."
"06_marketing/pr|Press releases, media kits, journalist contacts, coverage tracking."

"07_sales|Sales enablement, collateral, pricing, demos, proposals, and CRM data."
"07_sales/enablement|Battle cards, talk tracks, objection handlers, FAQs, training."
"07_sales/collateral|One-pagers, sales decks, datasheets, brochures."
"07_sales/pricing|Pricing models, tier definitions, discount policies, approval workflows."
"07_sales/demos|Demo scripts, demo environments, recordings."
"07_sales/proposals|RFP/RFI responses, proposal templates, win themes."
"07_sales/crm_data|Lead lists, account plans, pipeline reports, CRM exports."

"08_legal_compliance|Intellectual property, privacy, terms, regulatory, and licensing."
"08_legal_compliance/ip|Patents, trademarks, copyrights, IP assignments."
"08_legal_compliance/privacy|GDPR, CCPA, HIPAA artifacts; privacy policy; DPIAs; data flow maps."
"08_legal_compliance/terms|Terms of service, EULA, SLAs, master agreements."
"08_legal_compliance/regulatory|Industry-specific compliance evidence (PCI, SOC 2, ISO, FedRAMP, etc.)."
"08_legal_compliance/licensing|Software licenses, open-source license audits, third-party attribution."

"09_operations|Support, onboarding, runbooks, vendor management, and training."
"09_operations/support|Knowledge base articles, escalation paths, support SOPs."
"09_operations/onboarding|Customer onboarding playbooks, kickoff templates, success plans."
"09_operations/runbooks|Operational procedures, on-call rotations, incident response."
"09_operations/vendors|Third-party services, contacts, contract summaries, evaluations."
"09_operations/training|Internal training materials, LMS content, certification tracking."

"10_launch|Launch planning, beta program, release notes, comms, post-mortem."
"10_launch/launch_plan|Master launch checklist, launch RACI, go/no-go criteria."
"10_launch/beta|Beta program plans, participant lists, NDAs, feedback summaries."
"10_launch/release_notes|Internal and external release notes for each version."
"10_launch/comms|Internal announcements, external announcements, customer communications."
"10_launch/post_mortem|Launch retrospective, lessons learned, action items."

"11_finance|Business case, forecasts, pricing models, and financial reporting."
"11_finance/business_case|ROI analysis, NPV, payback period, business case approvals."
"11_finance/forecasts|Revenue, cost, and headcount projections; scenario models."
"11_finance/pricing_models|Unit economics, LTV/CAC, margin analysis."
"11_finance/reporting|Financial dashboards, P&L statements, variance reports."

"12_archive|Deprecated documents, superseded versions, retired artifacts."

"99_reference|External resources, inspiration, reference links, third-party docs."
)

# ---------- create folders ----------
for entry in "${FOLDERS[@]}"; do
    rel_path="${entry%%|*}"
    mkdir -p "$PROJECT_ROOT/$rel_path"
done

# ---------- write per-folder READMEs ----------
if [[ "$CREATE_FOLDER_READMES" == "true" ]]; then
    for entry in "${FOLDERS[@]}"; do
        rel_path="${entry%%|*}"
        description="${entry#*|}"
        folder_name="$(basename "$rel_path")"
        readme_path="$PROJECT_ROOT/$rel_path/README.md"

        cat > "$readme_path" <<EOF
# ${folder_name}

**Path:** \`${rel_path}\`

## Purpose

${description}

## What goes here

Document the contents and conventions for this folder. Suggested items:

- Naming convention for files in this folder
- Owner / point of contact
- Review or approval process (if applicable)
- Retention or archival policy

## What does NOT go here

Note any related content that belongs in a sibling or parent folder, with a pointer to the right location.

---
*Generated by scaffold_project.sh. Replace this template with project-specific guidance, or delete it using \`cleanup_folder_readmes.sh\` from the project root.*
EOF
    done
fi

# ---------- write root README ----------
ROOT_README="$PROJECT_ROOT/README.md"
cat > "$ROOT_README" <<EOF
# ${PROJECT_NAME}

This repository contains the working artifacts for the **${PROJECT_NAME}** product/project.
The structure is standardized across all product lines so contributors and stakeholders can
find what they need quickly.

## Conventions

- Folders are numerically prefixed (\`00_\`, \`01_\`, …) to enforce a logical workflow order
  rather than alphabetical order.
- \`00_admin\` and \`99_reference\` bookend the structure as catch-alls for governance and
  external reference material respectively.
- Each subfolder contains a \`README.md\` describing what belongs there. Replace the template
  with project-specific guidance, or remove the per-folder READMEs entirely with the cleanup
  script in this directory.

## Top-level structure

| Folder | Purpose |
|---|---|
| \`00_admin\` | Charter, governance, meetings, status reports, contracts, budget. |
| \`01_planning\` | Roadmap, requirements, backlog, risks, schedule, resource plan. |
| \`02_research\` | Market, competitive, customer, user testing, analytics. |
| \`03_design\` | UX, UI, accessibility. |
| \`04_engineering\` | Architecture, APIs, data, security, infrastructure, tech debt. |
| \`05_qa\` | Test plans, cases, results, defects, UAT. |
| \`06_marketing\` | Strategy, branding, content, campaigns, SEO/SEM, events, PR. |
| \`07_sales\` | Enablement, collateral, pricing, demos, proposals, CRM data. |
| \`08_legal_compliance\` | IP, privacy, terms, regulatory, licensing. |
| \`09_operations\` | Support, onboarding, runbooks, vendors, training. |
| \`10_launch\` | Launch plan, beta, release notes, comms, post-mortem. |
| \`11_finance\` | Business case, forecasts, pricing models, reporting. |
| \`12_archive\` | Deprecated and superseded artifacts. |
| \`99_reference\` | External resources, inspiration, reference links. |

## Full directory layout

\`\`\`
${PROJECT_NAME}/
├── 00_admin/
│   ├── charter/
│   ├── governance/
│   ├── meetings/
│   ├── status_reports/
│   ├── contracts/
│   └── budget/
├── 01_planning/
│   ├── roadmap/
│   ├── requirements/
│   ├── backlog/
│   ├── risks/
│   ├── schedule/
│   └── resource_plan/
├── 02_research/
│   ├── market_research/
│   ├── competitive_analysis/
│   ├── customer_research/
│   ├── user_testing/
│   └── analytics/
├── 03_design/
│   ├── ux/
│   │   ├── wireframes/
│   │   ├── user_flows/
│   │   ├── information_architecture/
│   │   └── prototypes/
│   ├── ui/
│   │   ├── mockups/
│   │   ├── design_system/
│   │   └── assets/
│   └── accessibility/
├── 04_engineering/
│   ├── architecture/
│   ├── api_specs/
│   ├── data/
│   ├── security/
│   ├── infrastructure/
│   └── technical_debt/
├── 05_qa/
│   ├── test_plans/
│   ├── test_cases/
│   ├── test_results/
│   ├── defects/
│   └── uat/
├── 06_marketing/
│   ├── strategy/
│   ├── branding/
│   │   ├── logo/
│   │   ├── styles/
│   │   ├── voice_tone/
│   │   └── templates/
│   ├── content/
│   │   ├── blog/
│   │   ├── whitepapers/
│   │   ├── case_studies/
│   │   ├── video/
│   │   └── social_media/
│   ├── campaigns/
│   ├── seo_sem/
│   ├── events/
│   └── pr/
├── 07_sales/
│   ├── enablement/
│   ├── collateral/
│   ├── pricing/
│   ├── demos/
│   ├── proposals/
│   └── crm_data/
├── 08_legal_compliance/
│   ├── ip/
│   ├── privacy/
│   ├── terms/
│   ├── regulatory/
│   └── licensing/
├── 09_operations/
│   ├── support/
│   ├── onboarding/
│   ├── runbooks/
│   ├── vendors/
│   └── training/
├── 10_launch/
│   ├── launch_plan/
│   ├── beta/
│   ├── release_notes/
│   ├── comms/
│   └── post_mortem/
├── 11_finance/
│   ├── business_case/
│   ├── forecasts/
│   ├── pricing_models/
│   └── reporting/
├── 12_archive/
└── 99_reference/
\`\`\`

## Cleanup

To remove the auto-generated \`README.md\` files in each subfolder (the root README is preserved):

\`\`\`bash
cd ~/${PROJECT_NAME}
./cleanup_folder_readmes.sh
\`\`\`

You can also re-scaffold a future project without per-folder READMEs by running the original
scaffolder with \`--no-folder-readmes\`.

---
*Scaffolded on $(date '+%Y-%m-%d') by scaffold_project.sh*
EOF

# ---------- write cleanup script ----------
CLEANUP_SCRIPT="$PROJECT_ROOT/cleanup_folder_readmes.sh"
cat > "$CLEANUP_SCRIPT" <<'CLEANUP_EOF'
#!/usr/bin/env bash
#
# cleanup_folder_readmes.sh
# ----------------------------------------------------------------------
# Removes the auto-generated README.md files from every subfolder of the
# project root, preserving the root README.md.
#
# Run from the project root:
#     ./cleanup_folder_readmes.sh
#
# Use -y / --yes to skip the confirmation prompt.
# ----------------------------------------------------------------------

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
ROOT_README="$SCRIPT_DIR/README.md"

ASSUME_YES=false
for arg in "$@"; do
    case "$arg" in
        -y|--yes) ASSUME_YES=true ;;
        -h|--help)
            echo "Usage: $(basename "$0") [-y|--yes]"
            echo "Removes README.md files from all subfolders, preserving the root README.md."
            exit 0
            ;;
        *)
            echo "Unknown argument: $arg" >&2
            exit 1
            ;;
    esac
done

# Find all README.md files except the one in the root.
mapfile -t TARGETS < <(find "$SCRIPT_DIR" -mindepth 2 -type f -name 'README.md')

if [[ ${#TARGETS[@]} -eq 0 ]]; then
    echo "No subfolder README.md files found. Nothing to do."
    exit 0
fi

echo "About to delete ${#TARGETS[@]} README.md file(s) from subfolders of:"
echo "  $SCRIPT_DIR"
echo "(The root README.md will be preserved.)"
echo

if [[ "$ASSUME_YES" != "true" ]]; then
    read -r -p "Proceed? [y/N] " confirm
    case "$confirm" in
        y|Y|yes|YES) ;;
        *) echo "Cancelled."; exit 0 ;;
    esac
fi

for f in "${TARGETS[@]}"; do
    rm -f "$f"
done

echo "Removed ${#TARGETS[@]} README.md file(s)."
echo "Root README preserved at: $ROOT_README"
CLEANUP_EOF

chmod +x "$CLEANUP_SCRIPT"

# ---------- summary ----------
TOTAL_FOLDERS=${#FOLDERS[@]}
echo
echo "✅ Project '$PROJECT_NAME' created at: $PROJECT_ROOT"
echo "   Folders created:        $((TOTAL_FOLDERS + 1))   (including root)"
if [[ "$CREATE_FOLDER_READMES" == "true" ]]; then
    echo "   Per-folder READMEs:     yes"
else
    echo "   Per-folder READMEs:     skipped (--no-folder-readmes)"
fi
echo "   Root README:            $ROOT_README"
echo "   Cleanup script:         $CLEANUP_SCRIPT"
echo
echo "Next steps:"
echo "   cd $PROJECT_ROOT"
echo "   # edit README.md to taste"
if [[ "$CREATE_FOLDER_READMES" == "true" ]]; then
    echo "   # ./cleanup_folder_readmes.sh   (to remove per-folder READMEs later)"
fi
