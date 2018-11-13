<template>
    <span v-if="lc"
      class="align-middle" :title="'Lifecycle phase '+status">
      <b-button
        :id="`btn_`+status"
        size="sm"
        class="md-4 mt-1 mr-1 px-2 align-middle lifecycle"
        :variant="btn"
        :to="to"
        @click="clicked"
        :pressed="isPressed">
        {{status | toUpperCase }}
      </b-button>
       <b-popover
        v-if="ispopup"
        :target="`btn_`+status"
        triggers="hover">
         <template slot="title">{{lc.name | toUpperCase | title}}</template>
        {{popup}}
      </b-popover>
    </span>
    <span v-else >
        <b-button
          size="sm"
          class="md-4 mt-1 mr-1 px-2 align-middle lifecycle"
          variant="outline-danger">
          Missing
      </b-button>
    </span>
</template>

<script>
  import lifeCycleMixin from '../mixins/lifeCycle.js'

	export default {
		name: 'lifeCycle',
		props: {
      status: {required: true},
      to: {type:String, required:false},
      ispopup: {type: Boolean, required: false, default: false},
      isPressed:  {type: Boolean, required: false, default: false},
  },
  mixins: [
    lifeCycleMixin
  ],
  lcText: {
    'Experimental': `A brand new, (possibly) bleeding edge technology that we want to investigate.`,
    'Testing': `
      <p>This is the part of the <strong>lifecycle</strong>, where we try out things.</p>
      <p>The technology seems to have <strong> significant advantages</strong> for some use cases, that are superior over the currently approved technologies. We want to explore this to learn more.</p>
      `,
    'POC': `
      <p>A technology, with well known characteristics, but either the technology or the operational capabilities / knowledge are not yet mature enough for full-scale production or critical applications.
      </p>
      <p>In order to gain a better understanding, we should do a Proof Of Concept - launch the technology in production, for a suitably chosen application.
      </p>
      `,
    'Default': `A mature technology, with well known characteristics, for which Nordea has a mature operational capability.
      No further questions asked, you can go ahead and use this technology to build your applications, for all the defined use cases.
      `,
    'Limited': `A mature technology, with well known characteristics, for which there is amature operational capability, but which for various reasons <em>(cost, licensing, strategic direction, etc, </em> it is desirable to limit the exceptional situations and use cases in which it is used.`,
    'deprecated': `A technology that we are actively phasing out (e.g. due to lack of support, security, stability, cost issues, impossible to staff, very inefficient in use or to be replaced with another technology, etc.)
      `,
    'DONT': `Must not be used, either for maintenance, or for new development. This is typically due to legal, policy or architecture reasons.`,
    'WIP': `#techmenu is currently working on updating the life cycle state of this technology`,
    'Undecided': `#techmenu has no opinion about this technology. Do we need it? Let us get this into #techmenu.`
  },
    computed: {
       lc () {
        return this.$store.getters.lifeCycle.items.filter( item => item.name === this.status).pop();
      },


    btn () {
      return this.btnVariant(this.lc ? this.lc.type : 'maybe');
    },

    popup() {
      return this.$options.lcText[(this.status)];
    }

  },
    filters: {
      capitalize: function( lower){
        return lower.charAt(0).toUpperCase() + lower.substr(1);
      },
      toUpperCase: function(upper){
        return upper.toUpperCase();
      },
      title: function( title){
        return 'Life cycle phase '+title;
      }
    },
    methods: {
      clicked(){
       return this.$emit('selected', this.status);
      }

    }

  }

</script>

<style scoped>
.lifecycle {
	min-width: 8em;
  max-width: 8em;
}
</style>
