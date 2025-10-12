---
title: Multi-Stream Coordination - Orchestra Section Management
category: coordination
status: active
last_updated: 2025-10-12
owner: system
tags: [coordination, multi-instance, orchestra, sections, harmony]
---

# Multi-Stream Coordination Strategy
## Coordinating Orchestra Sections for Harmonious Performance

🎵 **Core Principle**: Multiple Claude instances are like orchestra sections - each has unique instruments and parts, but all must play in harmony to create beautiful music together.

## Understanding Your Section (Stream/Instance)

### Your Orchestra Section Identity

When starting your session:

```markdown
## My Section in the Orchestra

**Section Name**: [Alpha, Beta, Gamma, etc.]
**Primary Instruments**: [Your technical focus areas]
**Current Movement**: [Project phase or sprint]
**Other Active Sections**: [Query orchestrator for active instances]
**Conductor Status**: [Orchestrator coordination state]
```

### Terminal Session: Your Rehearsal Space

- **Keep your section visible**: Session title should identify your focus area
- **Examples**:
  - "Alpha - API Documentation"
  - "Beta - User Guides"
  - "Gamma - Tutorial Series"
  - "Delta - Quality Review"

**Why**: Just as orchestra sections have designated spaces, your terminal session title helps everyone know which part of the documentation you're composing.

## Resource Coordination: Sharing Orchestra Resources

🎼 **Orchestral Principle**: Shared instruments (databases, test systems, files) must be coordinated to prevent cacophony.

### Resource Coordination Rules

#### Database Access: Limited Instruments
- **Rule**: Only one section performs database-modifying operations at a time
- **Why**: Like a rare instrument - only one musician can play it at once
- **Coordination**: Document in `main.md` when claiming database access
- **Duration**: Complete your performance within 30 minutes, then handoff

#### Performance Testing: Solo Performance Only
- **Rule**: Only Alpha section runs performance/load tests
- **Why**: Like a dramatic solo - needs the full stage (system resources)
- **Coordination**: Other sections pause resource-intensive work during performance tests
- **Notification**: Alpha announces performance test timing in `main.md`

#### File System: Sheet Music Protection
- **Rule**: Coordinate before editing shared files
- **Why**: Like sheet music - two musicians can't write on the same page simultaneously
- **Coordination**:
  1. Check `main.md` for active file work
  2. Announce your file claims
  3. Use worktrees/branches for parallel composition

#### Test Execution: Staggered Rehearsals
- **Rule**: Stagger test suite execution (5-10 minute gaps between sections)
- **Why**: Like rehearsal schedules - prevent resource conflicts
- **Coordination**:
  - Alpha: Top of hour (e.g., 2:00, 3:00)
  - Beta: 15 past (e.g., 2:15, 3:15)
  - Gamma: 30 past (e.g., 2:30, 3:30)
  - Delta: 45 past (e.g., 2:45, 3:45)

#### Port Usage: Instrument Tuning
- **Rule**: Each section gets specific port ranges
- **Why**: Like instrument tuning frequencies - must not overlap
- **Assignments**:
  - Alpha: 3000-3099
  - Beta: 3100-3199
  - Gamma: 3200-3299
  - Delta: 3300-3399
  - Epsilon: 3400-3499
  - (Continue pattern for additional sections)

## Communication Protocol: The Musical Score

### Main.md: The Conductor's Master Score

`main.md` is where the conductor (or lead musician) tracks the entire orchestra's performance.

**Update main.md when**:
- Starting work on a section/feature
- Claiming shared resources (database, files, test systems)
- Completing major milestones
- Encountering blocking issues
- Ready for integration/merge

**Main.md Structure**:
```markdown
# Orchestra Status - [Date]

## Active Sections
- **Alpha**: [Current work, resources claimed, status]
- **Beta**: [Current work, resources claimed, status]
- **Gamma**: [Current work, resources claimed, status]

## Resource Claims
- Database: [Section name, until time]
- Performance Testing: [Section name, until time]
- Critical Files: [List with claiming section]

## Integration Queue
- [Section name]: Ready for merge - [brief description]
- [Section name]: Pending review - [waiting on]

## Blocking Issues
- [Issue description] - Affects: [sections] - Owned by: [section]

## Completed Today
- [Section]: [Achievement with checkmarks]
- [Section]: [Achievement with checkmarks]
```

### Section Workstreams: Individual Sheet Music

Each section maintains their own workstream document (e.g., `alpha.md`, `beta.md`).

**Your section workstream should include**:
- Current work items with status
- Dependencies on other sections
- Handoff notes for next session
- Quality gate status
- Coordination needs

### Handoff Notes: Passing the Baton

When completing work or ending your session:

```markdown
## 🎵 Handoff from [Your Section]

### What I Composed Today
- [Specific achievement] ✅
- [Specific achievement] ✅
- [In-progress work] 🎼

### Ready for Next Musician
- [Files/sections ready for review/integration]
- [Tests passing]
- [Documentation updated]

### Still Needs Work
- [ ] [Incomplete task]
- [ ] [Blocked item] - Blocked by: [reason]

### Coordination Notes
- Coordinate with [Section] about [topic]
- [Resource] available for claim after [time]
- Watch for [potential conflict/dependency]

### Success Criteria Met
✅ Quality checks passing
✅ Documentation updated
✅ No regressions introduced
✅ Clean handoff possible
```

## Conflict Resolution: Orchestra Discipline

🎼 **Orchestral Principle**: When two musicians want the same instrument, we need clear, fair protocols.

### Priority Order: Section Leadership

When resource conflicts occur, follow this priority order:

1. **Alpha** - First chair (lead musician)
2. **Beta** - Second chair
3. **Gamma** - Third chair
4. **Delta** - Fourth chair
5. **Epsilon** - Fifth chair
6. **Zeta** - Sixth chair
7. **Eta** - Seventh chair
8. **Theta** - Eighth chair

**Priority applies to**:
- Simultaneous resource requests
- Tie-breaking in merge order
- Emergency access to shared systems

**Priority does NOT mean**:
- Alpha ignores coordination
- Lower sections must always wait
- Alpha can hold resources indefinitely

### Resource Contention: Fair Play

When a resource conflict occurs:

1. **Check Priority**: Higher priority section gets initial access
2. **Time-Box**: Maximum 2-hour resource hold, then mandatory handoff
3. **Document**: Log the conflict and resolution in `main.md`
4. **Communicate**: Lower priority section notes estimated wait time
5. **Pivot Option**: Lower priority section can work on independent tasks

**Example**:
```markdown
## Resource Conflict Resolution - 2:30 PM

**Situation**: Both Alpha and Gamma need database for integration tests

**Resolution**:
- Alpha proceeds (higher priority)
- Alpha commits to 30-minute max duration
- Gamma pivots to documentation updates
- Gamma will claim database at 3:00 PM

**Documented by**: Gamma section
```

### Deadlock Prevention: No Permanent Claims

**Rules**:
- **Maximum Hold**: 2 hours for any shared resource
- **Mandatory Handoff**: At 2-hour mark, release or explicitly renew
- **Renewal Requires**: Documented justification in `main.md`
- **Emergency Override**: If critical blocker, can request conductor intervention

### Escalation Path: When Sections Disagree

If coordination fails:

1. **Document in main.md**: Describe the unresolvable conflict
2. **Tag for Human Review**: Add `[NEEDS HUMAN COORDINATION]`
3. **Pause Conflicting Work**: Both sections halt contested work
4. **Continue Other Tasks**: Pivot to independent work items
5. **Await Guidance**: Human coordinator will review and decide

**Example**:
```markdown
## [NEEDS HUMAN COORDINATION]

**Conflict**: Alpha and Beta both claim architectural decision for API structure

**Alpha Position**: RESTful design with versioned endpoints
**Beta Position**: GraphQL design with schema evolution

**Impact**: Blocks 4 dependent features across both sections
**Duration**: 45 minutes of attempted coordination
**Request**: Human architect to make final call

Both sections pivoting to unblocked work items.
```

## Coordination Best Practices: Playing Well Together

### 1. Proactive Communication

✅ **Do**: Announce your plans before starting
✅ **Do**: Update `main.md` when claiming resources
✅ **Do**: Signal when releasing shared resources
✅ **Do**: Note dependencies on other sections

❌ **Don't**: Assume others know your plans
❌ **Don't**: Silently claim resources
❌ **Don't**: Hold resources longer than needed
❌ **Don't**: Create surprise dependencies

### 2. Respectful Resource Sharing

✅ **Do**: Honor agreed-upon time limits
✅ **Do**: Clean up after yourself (reset test data, close connections)
✅ **Do**: Leave resources in usable state for next section
✅ **Do**: Document any changes to shared resources

❌ **Don't**: Exceed time allocations without coordination
❌ **Don't**: Leave resources in broken state
❌ **Don't**: Make permanent changes without consensus
❌ **Don't**: Monopolize shared resources

### 3. Clear Handoffs

✅ **Do**: Complete your Definition of Done before signaling ready
✅ **Do**: Document what's ready vs. what's in-progress
✅ **Do**: Provide context for the next musician
✅ **Do**: Highlight any gotchas or special considerations

❌ **Don't**: Hand off broken or unverified work
❌ **Don't**: Assume the next musician will figure it out
❌ **Don't**: Leave critical context undocumented
❌ **Don't**: Skip quality gates "to save time"

### 4. Dependency Management

✅ **Do**: Map out dependencies before starting work
✅ **Do**: Communicate dependencies to affected sections
✅ **Do**: Provide estimated timelines for dependent work
✅ **Do**: Signal early if dependencies are blocked

❌ **Don't**: Create surprise dependencies
❌ **Don't**: Block other sections without warning
❌ **Don't**: Assume dependencies will resolve themselves
❌ **Don't**: Let dependency blockers linger undocumented

## Success Metrics: Harmonious Performance

### Individual Section
- ✅ Resources released within agreed time limits
- ✅ Clear documentation in `main.md` and section workstream
- ✅ No conflicts caused by poor coordination
- ✅ Handoffs enable seamless continuation

### Ensemble
- ✅ All sections progressing without blocking each other
- ✅ Resource conflicts resolved quickly and fairly
- ✅ Main.md accurately reflects orchestra status
- ✅ Integration proceeds smoothly across sections

### System
- ✅ Zero resource deadlocks
- ✅ Minimal human coordination needed
- ✅ Predictable, sustainable velocity
- ✅ High-quality output from all sections

## Daily Coordination Checklist

### Starting Your Session
- [ ] Read `main.md` to understand current orchestra status
- [ ] Identify your section's planned work
- [ ] Check for resource conflicts with your plans
- [ ] Announce your session start and resource needs in `main.md`
- [ ] Review dependencies on other sections

### During Your Work
- [ ] Update `main.md` when claiming shared resources
- [ ] Respect resource time limits
- [ ] Document blocking issues immediately
- [ ] Coordinate with affected sections proactively
- [ ] Keep section workstream current

### Ending Your Session
- [ ] Release all claimed resources
- [ ] Update `main.md` with completion status
- [ ] Create clear handoff notes in section workstream
- [ ] Document any conflicts or coordination needs
- [ ] Signal if work is ready for integration

---

*Remember: An orchestra creates magnificent symphonies not through individual virtuosity alone, but through disciplined, respectful, coordinated performance. Your adherence to these coordination practices enables our collective excellence.* 🎵
