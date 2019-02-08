<template>
<loading stuff="taxonomy" v-if="loading.tax" />
<b-form v-else>
  <b-list-group>
    <b-list-group-item>
      <h4>Classify the use case in the TBM Taxonomy</h4>
      <b-form-row>
        <b-form-group v-for="(level,index) in taxonomyLevels"  :key="index" v-show="isLeftDefined(index) && treeGeneration(index).length > 0" :id="'txLevel_'+level" :label="level" :label-for="'txSelect_'+level">
          <b-form-select :id="'txSelect_'+level" v-model="txModel[level]" :options="treeGeneration(index)" text-field="name" value-field="name" @change="updateTax(index)" class="mb-3" />
        </b-form-group>
      </b-form-row>
    </b-list-group-item>
    <b-list-group-item>
      <h4>Specify Usecases for Technology</h4>
      <b-button @click="addUsecase">
        Add Usecase
      </b-button>
      <b-list-group-item v-for="(usecase,index) in techModel.usecases"  :key="index">
        <b-form-group :id="'usecaseNameInputGroup_'+index" label="Name of usecase" :label-for="'usecaseNameInput_'+index" description="What is the usecase for the technology?">
          <b-form-input :id="'usecaseNameInput_'+index" type="text" v-model="techModel.usecases[index].name" required placeholder="Write usecase name - what problem are you trying to solve?">
          </b-form-input>
        </b-form-group>
        <b-form-group :id="'usecaseDescInputGroup_'+index" label="Description of usecase" :label-for="'usecaseDescInput_'+index" description="Describe, how should the technnology be used?">
          <b-form-textarea :id="'usecaseDescInput_'+index" v-model="techModel.usecases[index].description" placeholder="Descibe how to use this tech ..." :rows="3" :max-rows="6">
          </b-form-textarea>
        </b-form-group>
        <b-form-group :id="'usecaselcGroup_'+index" label="Lifecycle status of technology for this usecase" :label-for="'usecaselc_'+index" description="What is the current status of the tech for this usecase on Kumori?">
          <b-form-row>
            <b-form-select :id="'usecaselc_'+index" v-model="techModel.usecases[index].status" :options="lc" class="mb-3" />
            <life-cycle :status="techModel.usecases[index].status"></life-cycle>
          </b-form-row>
        </b-form-group>
      </b-list-group-item>
    </b-list-group-item>
  </b-list-group>
</b-form>
</template>

<script>
import Loading from '../components/Loading.vue'
import lifeCycleMixin from '../mixins/lifeCycle.js';

export default {
  name: 'UsecaseEditor',
  components: {
    Loading
  },
  mixins: [lifeCycleMixin],
  data() {
    return {
      loading: {
        tax: false
      },
      taxonomyModel: {
        newCapability: undefined,
        newUC: undefined
      },
      techModel: {
        uid: '',
        name: '',
        status: '',
        description: '',
        comments: [],
        tags: [],
        licenses: [],
        links: [],
        usecases: [],
        log: []
      },
      txModel: {}
    }
  },
  computed: {
    taxonomyLevels() {
      return this.$store.getters.taxonomy.levels.map(tx => tx.name)
    },
    txTree() {
      return this.buildTree(this.$store.getters.taxonomy.tags);
    }
  },
  created() {
    this.loading = {
      tax: true
    }
    this.$store
      .dispatch('fetchTaxonomy')
      .then(taxonomy => {
        this.loading.tax = false
      })

  },
  methods: {
    isLeftDefined(index) {
      if (index === 0) return true;
      const lookup = this.taxonomyLevels[index - 1];
      const leftSelection = this.txModel[lookup];
      return leftSelection !== null && leftSelection !== '';
    },
    /* Finds next generation in a tree at the level of leaf #n */
    treeGeneration(n) {
      console.log(`treegeneration>>> for index ${n}`)
      if (n === 0) return this.txTree;
      const lookup = this.taxonomyLevels[n - 1];
      const myNode = this.findNodeForName(this.txModel[lookup]);
      return myNode ? myNode.children : [];
    },
    /* Finds node in taxonomy tree with the given name */
    findNodeForName(name) {
      const stack = [...this.txTree];
      while (stack.length) {
        const node = stack.pop();
        if (node.name === name) return node;
        stack.push(...node.children);
      }
      return null;
    },
  }
}
</script>
