<template>
<b-modal ref="map_taxononmy" :title="title" @ok="save" @cancel="cancel">
<tax-select/>
</b-modal>
</template>

<script>
import {
  EventBus
} from "@/api/event-bus.js";
import TaxSelect from  "@/components/taxonomy/Select";
export default {
  name: "map-taxonomy",
  components: {
    "tax-select": TaxSelect,
  },
  data() {
    return {
      usecase: {
        id: undefined,
        name: undefined,
        description: undefined
      }
    }
  },
  mounted() {
    EventBus.$on("show-create-usecase-taxonomy-map-dialog", usecase => {
      this.usecase = usecase
      this.$refs.map_taxononmy.show();
    });
  },
  computed: {
    title() {
      return `Map taxonomies(s) to usecase "${this.usecase.name}"`
    }
  },
  methods: {
    save() {
      console.log('Not implemented')
    },
    cancel() {
      EventBus.$emit("update-usecase-list");
    }
  }
};
</script>

<style scoped></style>
