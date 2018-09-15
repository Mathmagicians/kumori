<template>
  <div id="about">
    <b-alert show variant="secondary">Here, you can read more about #techmenu, the process, the life cycle, the status.</b-alert>
    
    <b-card-group deck>
      <b-card title="Buy"
          img-src="../assets/buy.svg"
          img-alt="Image"
          img-top
          tag="article"
          class="mb-2 card-lifecycle" >
      <p class="card-text" v-html="phaseText['buy']"></p>
      <div slot="footer" class="text-center">
        <h6>Lifecycle phases for Buy</h6>
          <div v-for="item in buyItems">
            <span class="align-middle" v-b-popover.hover.html="popover[item]" :title="'Lifecycle phase '+item"  >
              <b-button class="md-4 px-2 align-middle btn-lifecycle" variant="outline-primary sm">{{item | capitalize }}
              </b-button>
          
              <b-button v-bind:id="item+'-info-btn'" variant="outline-secondary sm" class="btn-round">
                <v-icon name="question" scale="1"/></v-icon>
              </b-button>
            </span>
          </div>
        </div>
    </b-card>

    <b-card title="Hold"
          img-src="../assets/service.svg"
          img-alt="Image"
          img-top
          tag="article"
          class="mb-2 card-lifecycle">
      <p class="card-text" v-html="phaseText['hold']"></p>
      <div slot="footer" class="text-center">
        <h6>Lifecycle phases for Hold</h6>
        <div v-for="item in holdItems" >
          <span class="align-middle" v-b-popover.hover.html="popover[item]" :title="'Lifecycle phase '+item">
            <b-button class="md-4 px-2 align-middle btn-lifecycle" variant="outline-success sm">{{item | capitalize }}
            </b-button>
            <b-button v-bind:id="item+'-info-btn'" variant="outline-secondary sm" class="btn-round">
              <v-icon name="question" scale="1"/></v-icon>
            </b-button>
          </span>
        </div>
      </div>
    </b-card>

    <b-card title="Sell"
          img-src="../assets/exterminator.svg"
          img-alt="Image"
          img-top
          tag="article"
          class="mb-2 card-lifecycle">
      <p class="card-text" v-html="phaseText['sell']"></p>
      <div slot="footer" class="text-center">
        <h6>Lifecycle phases for Hold</h6>
        <div v-for="item in sellItems">
          <span class="align-middle" v-b-popover.hover.html="popover[item]" :title="'Lifecycle phase '+item">
            <b-button class="md-4 px-2 align-middle btn-lifecycle" variant="outline-danger lg">{{item | capitalize }}
            </b-button>
            <b-button v-bind:id="item+'-info-btn'" variant="outline-secondary sm" class="btn-round">
              <v-icon name="question" scale="1"/></v-icon>
            </b-button>
          </span>
        </div>
      </div>
    </b-card>

  	
  </b-card-group>
  </div>
</div>
</template>

<script>

  import LifeCycle from '../components/LifeCycle.vue'

  export default {

    name: 'about',
    components: {
      LifeCycle
    },
    computed: {
      popover(){
      // Returns the content as a string
      // Will be called each time popover is opened
        return this.lcText;
      },
      types: function(){
        let temp = this.$store.state.lifeCycle.items.map( item => item.type).filter((v, i, a) => a.indexOf(v) === i);
        return temp;

      },
      itemsForType: function() {
        const namesForType = type =>  this.$store.state.lifeCycle.items.filter( item => item.type === type).map( item => item.name);
        const myMap = new Map();
        this.types.forEach( type =>  myMap[type] = namesForType(type));
        return myMap;
      },
      maybeItems: function() {
        return this.itemsForType['maybe'];
      },
      buyItems: function() {
        return this.itemsForType['buy'];
      },
      holdItems: function() {
        return this.itemsForType['hold'];
      },
      sellItems: function() {
        return this.itemsForType['sell'];
      }
    },
    filters:{
      lowercase: function( astring ) {
        return astring.toLowerCase();
      },
      capitalize: function( lower){
        return lower.charAt(0).toUpperCase() + lower.substr(1);
      }
    },
    data() {
      return {
        el: "#about",
        img: {
          'buy': '../assets/buy.svg',
          'hold': '../assets/service.svg', 
          'sell': '../assets/exterminator.svg', 
          'maybe': '../assets/community.svg'
        },
        phaseText: 
        { 
          'maybe': `
            <h6>About the Buy Phase</h6>
            The status of this item has not been decided yet. Either it has not been investigated, or <strong>#techmenu</strong>'s community of experts, is currently investigating this item. `,
          'buy': `
            <h6>About the Buy Phase</h6>
            <p>
            The buy phase of technology lifecycle, is when we investigate and research. 
            We want to make it really, really easy to innovate.
            </p>
            <ul>
            <li>What new technologies should we use?</li>
            <li>What is trending and hot, what is hot air?</li>
            <li>What should be made into a service?</li>
            </ul>
            <p>
            When we try out new things, it is important to realize, that an experiment can either succeed or fail!
            In case of failure, lessons should be learned, and experiment should be thrown away, and we should move on happy, that it was only an experiment.
            </p>`,
          'hold': 
            `<h6>About the Hold Phase</h6>
            This phase of the lifecycle, is when a technology is well established, well known and mature. We know its quircks, we know how to deal with them.
            <p>There is no rational reason, to have too many tools that do the same job. Therefore technologies in this phase are subject to Formal Governance, an intentionally high wall, to protect ourselves from unnecessary complexity.</p>
            `,
          'sell': 
            `<h6>About the Sell Phase</h6>
            The day has come, where a technology has reached the end of the lifecycle, and should be retired. It is outdated, we have better alternatives, and it is really troublesome to keep supporting this oldie.
            <p>For the sake of the planet, let us reduce the carbon footprint, and clear this one from the data centers. </p>`
        },
        lcText: 
        {
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
        }
      }
    }

  }
</script>