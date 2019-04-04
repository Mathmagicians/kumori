<template>
<b-card no-body :id="project.name">
  <span slot="header" :v-b-toggle="accordionId">
    <b-button variant="link">
      {{project.name}}
    </b-button>
    <b-button to="/survey" variant="link">
      Survey
    </b-button>
    {{project.status.value}}
    <v-icon :name="statusIcon" color="grey" />
  </span>
  <div>
    {{project.status}}
  </div>

</b-card>
</template>

<script>
import Icon from 'vue-awesome/components/Icon'
import 'vue-awesome/icons/bolt'
import 'vue-awesome/icons/cloud'
import 'vue-awesome/icons/sun'

export default {
  name: 'project',
  icons: Object.freeze(['meteor', 'bolt', 'cloud', 'cloud', 'sun']),
  components: {
    'v-icon': Icon
  },
  props: {
    project: {
      type: Object,
      required: true
    }
  },
  computed: {
    accordionId: function () {
      return 'accordion-' + this.project.name;
    },
    statusIcon: function () {
      return this.iconNameFromValue(this.project.status.value)
    }
  },
  methods: {
    iconNameFromValue: function (val) {
      return val < 2 ? 'sun' : 'bolt'
    }
  }
}
</script>

<style scoped>
</style>
