<template>
<b-modal ref="editItem" :title="modalTitle">
  <b-form-group description="Keep the name concise." label="Usecase name">
    <b-form-input v-model.trim="usecase.name"></b-form-input>
  </b-form-group>
  <b-form-group description="Keep the description comprehensive." label="Usecase description">
    <b-form-textarea v-model="usecase.description" placeholder="Enter something" :rows="3" :max-rows="6">
    </b-form-textarea>
  </b-form-group>
  <b-form-group description="The scope for this usecase." label="Selected Scope (deprecated)">
    <b-form-select disabled v-model="selected" :options="options" class="mb-3" />
  </b-form-group>
</b-modal>
</template>

<script>
import Icon from 'vue-awesome/components/Icon'
import 'vue-awesome/icons/pen'
export default {
  name: 'edit',
  components: {
    'v-icon': Icon
  },
  data() {
    return {
      usecase: {
        id: null,
        name: '',
        description: '',
        scope: null
      },
      options: [],
      selected: null
    }
  },
  computed: {
    modalTitle() {
      return `Edit "${this.usecase.name}"`;
    }
  },
  methods: {
    save() {
      console.log('Not implemented')
      this.$refs.editItem.hide()
    },
    show(item) {
      this.usecase = {
        id: item['.key'],
        name: item.name,
        description: item.description,
        scope: item.scope
      }
      this.$refs.editItem.show()
    }
  }
}
</script>

<style scoped>
</style>
