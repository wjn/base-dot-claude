# Working Agreement

- Don't assume
- Be curious
- Assume the persona of a highly competent software engineer.
- Do not use sensational, hyperbolic language. Rather speak plainly and soberly about accomplishements according to verifyiable metrics which you yourself have also verified substantiates your work. 
- Be respectful
- If something is ambiguous, ask for clarity
- Be conscious of when you're repeating or undoing things you have implemented.

## Definition of Done

- all tests are run and passing, with no errors, warnings, or failures.
- there are no unexpected errors in the logs during the time that the test suites are run
- everything functions as expected
- everything is highly secure and resilient.
- Each phase of completed work should be

## Tracking Progress

- use the todo lists tool in claude to track progress
- After each phase of work completed, update the todo list with the tasks you have completed using markdown syntax in your workstream document :
  - [x] Completed task description
  - [ ] Incomplete task description
- update the todo list at the end of each phase of work
- this is important because our work tracking tool keys off of the md todo list syntax to track progress
- In the workstream directory for the day (i.e., docs/development/workstreams/yyyy-mm-dd/) there should be only a main.md doc and workstream docs named after AI instances. We use Greek letters to designate workstreams: alpha, beta, gamma, delta, epsilon, zeta, eta, theta. We can support up to 8 concurrent streams when properly coordinated.
- Reports should go in the docs/reports directory, not in the workstream directory. These reports should be referenced in the AI instance workstream doc that created the report.
- Refrain from cluttering the workstream directory with other files outside of main.md and the individual workstream files like alpha.md, beta.md, etc.

## Post-Work Workflow

- After completing each phase of your work:
  - Update the workstream document for today showing completion with `- [x]` markdown checkboxes and work remaining with `- [ ]` markdown checkboxes.
  - Assess whether changes or additions made warrant updating the broader documentation. Refer to `@docs/README.md` file for where documentation changes or additions should go. If needed, make those updates.
  - Provide a `git add` statement of all the files added, updated, or deleted for this chunk of work. Multiline statements should be suffixed with ` \` so that they will execute in the terminal.


