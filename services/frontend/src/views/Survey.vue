<template>
<b-container>
  <h1>Survey</h1>
  <b-form>
    <b-tabs content-class="mt-3">
      <b-tab title="Base info" active>
        <b-form-group label="Project">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Application Provider">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Product Owner">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Team Lead">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Link to architecture documentation">
          <b-form-input type="url" />
        </b-form-group>
        <b-form-group label="Link to code repo">
          <b-form-input type="url" />
        </b-form-group>
        <b-form-group label="Life cycle stage">
          <b-form-select :options="[
                'initial',
                'proof of concept',
                'proof of business',
                'mature',
                'sunsetting'
              ]" />
        </b-form-group>
      </b-tab>
      <b-tab title="Strategy">
        <b-form-group label="Problem formulation">
          <b-form-textarea placeholder="What problem are you trying to solve" rows="3" max-rows="6" />
        </b-form-group>
        <b-form-group label="Goals">
          <b-form-textarea placeholder="Are the goals for the project clearly defined" rows="3" max-rows="6" />
        </b-form-group>
        <b-form-group label="Drivers">
          <b-form-textarea placeholder="Are the strategic drivers defined? Are the technological drivers defined?" rows="3" max-rows="6" />
        </b-form-group>
      </b-tab>
      <b-tab title="Requirements">
        <b-form-group label="Non Functional requirements">
          <b-form-group label="Are the non-functional capabilities clearly defined?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Do they follow from strategic goals?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Are the non-functional requirements written down and explicit?">
            <b-form-checkbox />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Expected load">
          <b-form-group label="Daily users">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="size of data set?">
            <b-form-input type="text" />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Resiliency level">
          <b-form-group label="Standard / High Availability / Business Critical">
            <b-form-input type="text" />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Usability">
          <b-form-group label="Human factors">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Aesthetics">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Consistency">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Documentation">
            <b-form-input type="text" />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Reliability">
          <b-form-group label="Frequency/severity of failure">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Recoverability">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Predictability">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Accuracy">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Mean time to failure">
            <b-form-input type="text" />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Performance">
          <b-form-group label="Speed">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Efficiency">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Resource consumption">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Throughput">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Response time">
            <b-form-input type="text" />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Supportability">
          <b-form-group label="Testability">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Extensibility">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Adaptability">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Maintainability">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Compatibility">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Configurability">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Serviceability">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Installability">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Localizability">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Portability">
            <b-form-input type="text" />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Security requirements">
          <b-form-group label="Confidentiality">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Integrity">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Availability">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Non-repudiation">
            <b-form-input type="text" />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Users">
          <b-form-group label="Who are the users of the application?">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="Do the users participate in the design process?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Do the users participate in the testing process?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Does the application have technical users?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Does the application have Internal users ?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Does the application have external users?">
            <b-form-checkbox />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Connectivity">
          <b-form-group label="Does the application have external connectivity?">
            <b-form-checkbox />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Confidentiality">
          <b-form-group label="How is the confidentiality of the data assets classified?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="How is Need to know policy implemented?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Does the project have a setup for Risk
Management ?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Does the project reuse
the organizational security knowledge?">
            <b-form-checkbox />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Compliance with other initiatives">
          <b-form-group label="Compliance with other projects in business area">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Compliance with other organizational projects">
            <b-form-checkbox />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Risk">
          <b-form-group label="Does the project have a setup for Risk Management?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Does the project have a risk log?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Compliance with laws and regulations">
            <b-form-checkbox />
          </b-form-group>
        </b-form-group>
      </b-tab>
      <b-tab title="Business">
        <b-form-group label="Functional Requirements">
          <b-form-group label="Are the functional requirements for the project written down and explicit?">
            <b-form-checkbox />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Timeline">
          <b-form-group label="Does the project have a defined project plan">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Does the project have partial deliverables">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Are deadlines based on estimates">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Does work happen iteratively">
            <b-form-checkbox />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Budget">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Team">
          <b-form-group label="development">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="testing">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="devops">
            <b-form-input type="text" />
          </b-form-group>
          <b-form-group label="business">
            <b-form-input type="text" />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Governance">
          <b-form-group label="Does the project have a business owner?">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Is the business owner participating actively in the project?">
            <b-form-checkbox />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Dependencies">
          <b-form-input type="text" />
        </b-form-group>
      </b-tab>
      <b-tab title="Process">
        <b-form-group label="Project planning">
          <b-form-textarea placeholder="What problem are you trying to solve" rows="3" max-rows="6" />
        </b-form-group>
        <b-form-group label="Development process">
          <b-form-textarea placeholder="What problem are you trying to solve" rows="3" max-rows="6" />
        </b-form-group>
        <b-form-group label="Quality assurance">
          <b-form-textarea placeholder="What problem are you trying to solve" rows="3" max-rows="6" />
        </b-form-group>
      </b-tab>
      <b-tab title="Technology">
        <b-form-group label="Source code">
          <b-form-group label="The source code is checked into a repository">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Frequent commits">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="Development branches">
            <b-form-checkbox />
          </b-form-group>
          <b-form-group label="There are code guidelines for the project, synchronized with CM code guidelines, and used by the project members">
            <b-form-checkbox />
          </b-form-group>
        </b-form-group>
        <b-form-group label="Code Documentation">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Architecture Documentation">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Architecture Principles">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Licensing">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Technology stack">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Technical debt">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Integrations patterns">
          <b-form-input type="text" />
        </b-form-group>
        <b-form-group label="Data Model">
          <b-form-input type="text" />
        </b-form-group>
      </b-tab>
    </b-tabs>
  </b-form>
</b-container>
</template>

<script>
export default {
  name: "Projects",
  components: {},
  data() {
    return {};
  }
};
</script>

<style scoped>
.b-form-group>div>.b-form-group {
  margin-left: 60px;
}
</style>
