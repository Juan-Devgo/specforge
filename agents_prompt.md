I need you to read these skills and make agents (files in .md) for running all the workflow of SDD. These files must be as simple as possible since the skills say everything the agent may need. Also, define which skills the
  agent needs and allowed actions for each agent, for example, the plannerr is responsible for asking the user (only he can). These actions must follow the principle of lowest privilege.

  I need a planner agent that is able to run different subagents:

  * When I say use the coordinator or start with another development loop -> Use the planner.
  * He is responsible for running sdd-constitution, sdd-agents, sdd-spec so he tells the user "Put your constitution, agents or spec prompt here" and then he runs the corresponding skill.
  * Don't run sdd-constitution or sdd-agents if the files are already created unless, the user asks for an amendment in any of these files, just ask for the new spec prompt.
  * When the spec is completed, he will run a clarifier subagent for clarifying the spec (sdd-clarification). This subagent will make requests for asking the user, the planner is responsible for asking that to the user.
  * When the clarifier finishes, he will make a request for approve the spec, the planner is responsible for asking that to the user.
  * Then, the planner will run a technician subagent to make the technical plan and the tasks (sdd-plan, sdd-tasks).
  * When the technician finishes, the planner will run a developer subagent that implement the tasks (sdd-implement) phase by phase: the developer finishes a phase, then he reports the planner, the planner tells the user and
  the planner immediately finishes that subagent and run another one with its context clean to start the next phase.
  * When the developer finishes, run a validator subagent that validates everything (sdd-validation).
  * Finnaly, the validator report the user and the planner report to the user.

  All agents must communicate with each other as simple as possible with JSON format, examples:

  From the planner to developer:

  {
    request: "Implement the next phase."
  }

  From developer to planner:

  {
    report: "Phase 2 implemented",
    changes: "<Summary of the changes>",
    tests: "Everything green, On test 3: the result was 100ms (Under 500ms, <linked AC>)..."
  }

  From clarifier to planner:

  {
    report: "I review the spec and I found several ambiguities and conflicts",
    conflicts: "Constitution says that..., but the spec says that...",
    request: "Ask the user these 10 questions.",
    questions: ["1. ¿What if...?", "..."]
  }