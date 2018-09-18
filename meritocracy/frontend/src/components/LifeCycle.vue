<template>
  <span>
    <span v-if="lc"
      class="align-middle"  :title="'Lifecycle phase '+status"  >
      <b-button class="md-4 px-2 align-middle btn-lifecycle" :variant="btnVariant" 
        :to="to" 
        v-b-popover.hover="popup" 
        :title="lc.name | toUpperCase | title">
        {{status | toUpperCase }}
      </b-button>
    </span>
     <span v-else >
        <b-button class="md-4 px-2 align-middle btn-lifecycle" variant="outline-danger sm">
        MISSING
        <v-icon name="times"  scale="2"></v-icon>
      </b-button>
    </span>
  </span>
</template>

<script>	
	export default {
		name: 'lifeCycle',
		props: {
      status: {required: true},
      to: {type:String, required:false},
      ispopup: {type: Boolean, required: false, default: false}
    },
    variant : {
      maybe: "outline-secondary",
      buy: "outline-primary", 
      hold: "outline-success",
      sell: "outline-danger"
    },
    lcText: {
      'experimental': `A brand new, (possibly) bleeding edge technology that we want to investigate.`,
      'testing': `
      <p>This is the part of the lifecycle, where we try out things.</p>
      <p>The technology seems to have <strong> significant advantages</strong> for some use cases, that are superior over the currently approved technologies. We want to explore this to learn more.</p>
      `,
      'poc': `
      <p>A technology, with well known characteristics, but either the technology or the operational capabilities / knowledge are not yet mature enough for full-scale production or critical applications.
      </p>
      <p>In order to gain a better understanding, we should do a Proof Of Concept - launch the technology in production, for a suitably chosen application.
      </p>
      `,
      'default': `A mature technology, with well known characteristics, for which Nordea has a mature operational capability.
      No further questions asked, you can go ahead and use this technology to build your applications, for all the defined use cases.
      `,
      'limited': `A mature technology, with well known characteristics, for which there is amature operational capability, but which for various reasons <em>(cost, licensing, strategic direction, etc, </em> it is desirable to limit the exceptional situations and use cases in which it is used.`,
      'deprecated': `A technology that we are actively phasing out (e.g. due to lack of support, security, stability, cost issues, impossible to staff, very inefficient in use or to be replaced with another technology, etc.)
      `,
      'dontuse': `Must not be used, either for maintenance, or for new development. This is typically due to legal, policy or architecture reasons.`,
      'wip': `#techmenu is currently working on updating the life cycle state of this technology`,
      'undecided': `#techmenu has no opinion about this technology. Do we need it? Let us get this into #techmenu.`
    },
    computed: {
       lc: function(){
        return this.$store.state.lifeCycle.items.filter( item => item.name === this.status).pop();
      },

      btnVariant: function() {
       return this.$options.variant[this.lc? this.lc.type: 'maybe']; 
      },

      popup: function(){
        return this.ispopup?this.$options.lcText[this.lc.name]:'';
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

    }
	}
	
</script>