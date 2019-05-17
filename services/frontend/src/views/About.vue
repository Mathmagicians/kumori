<template>
  <loading v-if="loading" stuff="lifecycle data" />
  <div v-else id="about">
    <b-alert show variant="secondary"
      >Here, you can read more about Kumori, the process, the life cycle, the
      status.</b-alert
    >
    <b-card-group deck>
      <b-card
        v-for="type in types"
        :key="type.name"
        :title="type | capitalize"
        :img-src="images(type)"
        img-alt="Image"
        img-top
        tag="article"
        class="mb-2 card-lifecycle"
      >
        <p class="card-text" v-html="texts(type)"></p>
        <div slot="footer" class="text-center">
          <h6>Lifecycle phases for {{ type | capitalize }}</h6>
          <b-list-group flush>
            <b-list-group-item v-for="item in itemsForType[type]" :key="item">
              <life-cycle :status="item"></life-cycle>
            </b-list-group-item>
          </b-list-group>
        </div>
      </b-card>
    </b-card-group>
  </div>
</template>

<script>
import LifeCycle from "../components/LifeCycle.vue";
import lifeCycleMixin from "../mixins/lifeCycle.js";
import Loading from "../components/Loading.vue";

export default {
  name: "about",
  created() {
    this.loading = true;
    this.$store.dispatch("fetchLifeCycle").then(() => {
      this.loading = false;
    });
  },
  data() {
    return {
      loading: false
    };
  },
  phaseText: {
    Maybe: `
      <h6>About the Maybe Phase</h6>
      The status of this item has not been decided yet. Either it has not been investigated, or <strong>Kumori</strong>'s community of experts, is currently investigating this item. `,
    Buy: `
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
    Hold: `<h6>About the Hold Phase</h6>
      This phase of the lifecycle, is when a technology is well established, well known and mature. We know its quircks, we know how to deal with them.
      <p>There is no rational reason, to have too many tools that do the same job. Therefore technologies in this phase are subject to Formal Governance, an intentionally high wall, to protect ourselves from unnecessary complexity.</p>
      `,
    Sell: `<h6>About the Sell Phase</h6>
      The day has come, where a technology has reached the end of the lifecycle, and should be retired. It is outdated, we have better alternatives, and it is really troublesome to keep supporting this oldie.
      <p>For the sake of the planet, let us reduce the carbon footprint, and clear this one from the data centers. </p>`
  },
  components: {
    LifeCycle,
    Loading
  },
  mixins: [lifeCycleMixin],
  filters: {
    capitalize: function(lower) {
      return lower.charAt(0).toUpperCase() + lower.substr(1);
    }
  },
  methods: {
    texts: function(type) {
      return this.$options.phaseText[type];
    }
  }
};
</script>

<style scoped>
.card-img-top {
  height: 200px;
}
</style>
