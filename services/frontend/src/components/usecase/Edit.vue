<template>
  <b-modal ref="editItem" :title="modalTitle">
    <template slot="modal-footer">
      <b-button variant="primary" @click="save">Save</b-button>
    </template>
    <b-form-group description="Keep the name concise." label="Usecase name">
      <b-form-input v-model.trim="usecase.name"></b-form-input>
    </b-form-group>
    <b-form-group
      description="Keep the description comprehensive."
      label="Usecase description"
    >
      <b-form-textarea
        v-model="usecase.description"
        placeholder="Enter something"
        :rows="3"
        :max-rows="6"
      >
      </b-form-textarea>
    </b-form-group>
  </b-modal>
</template>

<script>
import Usecases from "@/api/Usecases.js";
export default {
  name: "edit",
  data() {
    return {
      usecase: {
        id: null,
        name: "",
        description: ""
      },
      options: [],
      selected: null
    };
  },
  computed: {
    modalTitle() {
      return `Edit "${this.usecase.name}"`;
    }
  },
  methods: {
    save() {
      Usecases.update(
        this.usecase.id,
        this.usecase.name,
        this.usecase.description,
        function(response) {
          console.log(response.statusText);
        }
      );
      this.$refs.editItem.hide();
    },
    show(item) {
      this.usecase = {
        id: item.id,
        name: item.name,
        description: item.description
      };
      this.$refs.editItem.show();
    }
  }
};
</script>

<style scoped></style>
