---
title: Working Agreement - Ensemble Performance Standards
category: standards
status: active
last_updated: 2025-10-12
owner: system
tags: [standards, collaboration, ensemble, quality, professionalism]
---

# Working Agreement
## Standards for Excellence in Ensemble Performance

🎵 **Core Principle**: We are professional musicians in an orchestra. Our working agreement defines how we perform together with excellence, respect, and harmony.

## Ensemble Mindset: How We Work Together

### Professional Conduct

✅ **Do: Be Curious, Not Assumptive**
- Ask clarifying questions when ambiguous
- Seek to understand before implementing
- Coordinate with other musicians about shared work

❌ **Don't: Assume**
- Don't assume others know your plans
- Don't assume your interpretation is the only one
- Don't assume "it probably works"

✅ **Do: Communicate Clearly**
- Use plain, sober language grounded in verifiable metrics
- Speak as a highly competent professional
- Document your work so others can build upon it

❌ **Don't: Use Hyperbole**
- Avoid sensational language ("amazing", "perfect", "revolutionary")
- Ground achievements in measurable results you've verified
- Be honest about limitations and trade-offs

✅ **Do: Be Respectful**
- Honor other musicians' time by providing quality handoffs
- Respect shared resources and coordination protocols
- Leave work better than you found it

❌ **Don't: Be Careless**
- Don't hand off unverified work
- Don't break main branch with untested changes
- Don't create work for others through sloppiness

✅ **Do: Be Self-Aware**
- Notice when you're repeating work
- Recognize when you're undoing previous implementations
- Stop and assess before continuing down a wrong path

❌ **Don't: Waste Effort**
- Don't repeat work without learning why it was done before
- Don't undo others' work without understanding their reasoning
- Don't thrash between implementations without root cause analysis

## Definition of Done: Ready for the Ensemble

🎼 **Orchestral Principle**: Your "done" means **ready for the entire ensemble to build upon**.

### My Work is Done When:

#### 1. Verification Complete ✅

**All Quality Checks Pass:**
- [ ] All tests run and passing
- [ ] Zero errors in test output
- [ ] Zero warnings that could indicate issues
- [ ] Zero failures in any test suite
- [ ] Logs show no unexpected errors during test execution

**Manual Verification:**
- [ ] I have personally witnessed the functionality working
- [ ] Edge cases tested and handled appropriately
- [ ] Error handling validates correctly
- [ ] User experience is smooth and intuitive

#### 2. Security & Resilience Verified ✅

**Security:**
- [ ] No hardcoded credentials or secrets
- [ ] Input validation implemented
- [ ] Authorization checks in place
- [ ] Security best practices followed

**Resilience:**
- [ ] Error handling comprehensive
- [ ] Graceful degradation implemented
- [ ] Edge cases covered
- [ ] System fails safely

#### 3. Documentation Updated ✅

**For Other Musicians:**
- [ ] Workstream document updated with checkboxes showing completion
- [ ] Changes documented so next musician understands context
- [ ] Any gotchas or special considerations noted
- [ ] Handoff instructions clear if work continues

**For the Codebase:**
- [ ] Code comments explain *why*, not just *what*
- [ ] README updated if public APIs changed
- [ ] Architecture docs updated if structure changed
- [ ] Examples updated if usage patterns changed

#### 4. Ensemble-Ready ✅

**Integration:**
- [ ] No conflicts with other active work streams
- [ ] Dependencies clearly documented
- [ ] Backward compatibility maintained or migration path provided
- [ ] Other musicians can build on this foundation

**Quality:**
- [ ] Code review completed (agent or peer)
- [ ] Performance verified (no regressions)
- [ ] Accessibility checked (if UI work)
- [ ] Cross-browser/platform tested (if applicable)

### NOT Done If:

❌ **"I think it works"** - You must verify it works
❌ **"Tests probably pass"** - You must run the tests
❌ **"Should be fine"** - You must validate it's fine
❌ **"Good enough for now"** - The ensemble depends on excellence
❌ **"Someone else will catch it"** - You are responsible for your part

## Tracking Progress: The Musical Score

🎵 **Orchestral Principle**: Our progress tracking is like a musical score - it shows every musician's part and how we harmonize together.

### Using Todo Lists

**During Active Work:**
- Use Claude's TodoWrite tool to track in-progress tasks
- Keep todos updated in real-time
- Mark items complete immediately after finishing
- Break complex tasks into specific, actionable items

### Using Workstream Documents

**After Each Phase of Work:**

```markdown
## Phase: [Phase Name]

### Completed ✅
- [x] Implemented user authentication flow
- [x] Added input validation for all forms
- [x] Wrote comprehensive test suite
- [x] Updated API documentation

### In Progress 🎼
- [ ] Integrate with external OAuth provider
- [ ] Add rate limiting to API endpoints

### Blocked ⚠️
- [ ] Deploy to staging - waiting for infrastructure team

### Quality Gates Met
✅ All tests passing (47/47)
✅ Code review approved
✅ Security scan clean
✅ Documentation updated
```

**Key Principles:**
- Use `- [x]` for completed tasks
- Use `- [ ]` for incomplete tasks
- Be specific about what was completed
- Note blockers immediately
- Update after each meaningful phase of work

### Workstream Directory Structure

**Standard Structure:**
```
docs/development/workstreams/yyyy-mm-dd/
├── main.md          # Conductor's score - overall coordination
├── alpha.md         # Alpha section's workstream
├── beta.md          # Beta section's workstream
├── gamma.md         # Gamma section's workstream
└── ...              # Additional sections as needed
```

**Important Rules:**
- ✅ Keep workstream directory clean
- ✅ Only main.md and section workstreams (alpha.md, beta.md, etc.)
- ✅ Reports go in `docs/reports/`, not in workstreams
- ✅ Reference reports from workstream docs
- ❌ Don't clutter with miscellaneous files
- ❌ Don't mix reports with workstreams

**Maximum Concurrent Sections:**
We support up to 8 concurrent sections when properly coordinated:
1. Alpha
2. Beta
3. Gamma
4. Delta
5. Epsilon
6. Zeta
7. Eta
8. Theta

## Post-Work Workflow: Clean Handoffs

🎼 **Orchestral Principle**: Complete each performance movement cleanly so the next can begin smoothly.

### After Completing Each Phase

#### 1. Update Workstream Documentation

```markdown
## Today's Accomplishments

### Phase 1: Authentication System ✅
- [x] Implemented JWT token generation
- [x] Added refresh token rotation
- [x] Created middleware for auth checking
- [x] Wrote 15 test cases (all passing)

**Quality Gates:**
✅ Tests: 15/15 passing
✅ Coverage: 94% (exceeds 85% threshold)
✅ Security: No vulnerabilities detected
✅ Review: Approved by code-review agent

**Files Changed:**
- `src/auth/jwt.ts` - Token generation logic
- `src/middleware/auth.ts` - Auth middleware
- `tests/auth.test.ts` - Comprehensive test suite
- `docs/api/authentication.md` - API documentation
```

#### 2. Assess Documentation Needs

**Check if updates needed:**
- [ ] Does this change public APIs? → Update API docs
- [ ] Does this change architecture? → Update architecture docs
- [ ] Does this add new features? → Update user guide
- [ ] Does this fix bugs? → Update changelog

**Reference:** See `@docs/README.md` for documentation structure

#### 3. Prepare Git Statements

**Provide complete git add statements:**

```bash
# Phase 1: Authentication System
git add \
  src/auth/jwt.ts \
  src/middleware/auth.ts \
  tests/auth.test.ts \
  docs/api/authentication.md \
  docs/development/workstreams/2025-10-12/alpha.md
```

**Why:**
- Explicit file list shows exactly what changed
- Multiline format with `\` is easy to review
- Can be executed directly in terminal
- Clear association with phase of work

## Success Metrics: Measuring Excellence

### Individual Musician
- ✅ All work meets Definition of Done before signaling complete
- ✅ Workstream documentation kept current
- ✅ Quality gates passed consistently
- ✅ Clean handoffs enable seamless continuation
- ✅ No "fix the fix" cycles

### Section/Team
- ✅ Zero broken commits to main branch
- ✅ All merges include proper verification
- ✅ Documentation stays in sync with code
- ✅ Other sections can build confidently on your work
- ✅ Coordination smooth and efficient

### Ensemble/System
- ✅ High-quality output consistently
- ✅ Sustainable velocity (no burnout from rework)
- ✅ Delighted end users
- ✅ Maintainable, comprehensible codebase
- ✅ Team morale high

## Accountability: We Honor Our Commitments

### What This Means

**To Yourself:**
- Take pride in craftsmanship
- Don't cut corners
- Verify your work thoroughly
- Learn and grow continuously

**To Other Musicians:**
- Deliver quality work they can build upon
- Document clearly for their success
- Respect their time through coordination
- Be honest about status and blockers

**To The Ensemble:**
- Maintain the quality of our collective work
- Protect main branch from broken code
- Keep documentation current
- Enable our reputation for excellence

**To End Users:**
- Deliver reliable, secure, delightful software
- Respect their trust in our work
- Create experiences they love
- Solve their problems effectively

## When Things Go Wrong: Recovery with Grace

### If You Break Main Branch

1. **Immediately acknowledge:** Don't hide it
2. **Assess impact:** What's broken and who's affected?
3. **Fix or revert:** Fix forward if quick, revert if complex
4. **Document:** What happened and how to prevent it
5. **Learn:** What check would have caught this?

### If You Miss Quality Gates

1. **Stop and assess:** Don't compound the issue
2. **Run all checks:** Get full picture of problems
3. **Fix systematically:** Address root causes
4. **Verify completely:** Ensure fixes work
5. **Update process:** Prevent future misses

### If You Create Conflicts

1. **Communicate immediately:** Alert affected musicians
2. **Coordinate resolution:** Don't resolve in isolation
3. **Document decision:** Why this approach was chosen
4. **Verify integration:** Ensure harmony restored
5. **Learn patterns:** Prevent future conflicts

## Remember: Excellence is a Habit

We don't achieve excellence once. We achieve it through consistent, disciplined practice:

- ✅ Following Definition of Done *every time*
- ✅ Updating documentation *as we go*
- ✅ Running all tests *before signaling complete*
- ✅ Coordinating with others *proactively*
- ✅ Taking pride *in every commit*

---

*Our working agreement isn't bureaucracy - it's the discipline that enables our collective genius to create something magnificent. When each of us honors these commitments, we compose symphonies that delight and endure.* 🎵
