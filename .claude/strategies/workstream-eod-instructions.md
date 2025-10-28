# Workstream End-of-Day Instructions ## Overview
These instructions guide the end-of-day (EOD) handoff process for workstream documentation, ensuring seamless continuity between working sessions. ## Process ### 1. Initial Review
Begin by internalizing the `@CLAUDE.md` agreement. Review the development notes in `@docs/workstreams/`, starting with:
- Today's main workstream document: `@docs/workstreams/[TODAY'S_DATE]/main.md`
- Your specific workstream plan document: `@docs/workstreams/[TODAY'S_DATE]/[WORKSTREAM_NAME].md` ### 2. Update Today's Workstream Document
After completing your assessment, **update** (not create new) today's workstream document:
`@docs/workstreams/[TODAY'S_DATE]/[WORKSTREAM_NAME].md` Refactor the document to be easily consumable as a handoff for the next working session. ### 3. Required Document Structure The updated document must include: #### Table of Contents
- Links to all section headings for easy navigation #### Executive Summary
- High-level overview of work completed today #### Detailed Work Account
- **Tasks completed** (marked with `- [x]`)
- **Tasks in progress** (marked with `- [ ]`)
- **Blockers or issues** encountered
- **Key decisions** made #### Code Changes Summary
- Files modified with brief description of changes
- New files created and their purpose
- Tests added or updated
- Any refactoring performed #### Integration Points
- Dependencies on other workstreams
- Interfaces or APIs exposed for other workstreams
- Coordination needed with other workstreams #### Next Session Priorities
- Most critical tasks to tackle first
- Estimated time for remaining work
- Any prerequisites or dependencies #### Handoff Notes
- Current state of the codebase in this workstream's area
- Any uncommitted changes and their status
- Environment setup or configuration changes
- Testing status and any failing tests
- Special instructions for continuing the work ### 4. Tracking Standards
Ensure all outcomes, tasks, and deliverables are tracked with markdown checkboxes:
- `- [ ]` for work remaining
- `- [x]` for work completed ### 5. Primary Outcome
The main goal is that in the next working session, another Claude instance assigned to the workstream should be able to use the updated workstream document as a comprehensive handoff to seamlessly continue the work. ### 6. Final Verification
After updating the workstream document:
- Verify all completed work is properly documented
- Ensure any partial work has clear notes on what remains
- Confirm that the handoff information is complete and actionable
- Update any relevant project documentation if changes warrant it (refer to `@docs/README.md` for guidance) ## Key Principles
- **Continuity**: Enable seamless handoff between sessions
- **Clarity**: Document decisions and blockers explicitly
- **Completeness**: Include all context needed to resume work
- **Actionability**: Provide clear next steps and priorities