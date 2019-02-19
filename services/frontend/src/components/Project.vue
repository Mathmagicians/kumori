<template>
<b-card no-body :id="project.name">
  <span slot="header" :v-b-toggle="accordionId">
    <b-button variant="link">
      {{project.name}}
    </b-button>
    {{project.status.value}}
      <weather :state="project.status.value" size="16" />
  </span>
  <div>
    {{project.status}}
  </div>

</b-card>
</template>

<script>

import Weather from '@/components/Weather'

export default {
  name: 'project',
  components: {
    'weather': Weather
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
    iconNameFromValue: function(val) {
        return val<2 ? 'sun' : 'bolt'
    }
  }
}
</script>

<style scoped>
</style>
