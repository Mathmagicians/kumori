<template>
<div>
  <list-usecase />
  <edit-usecase />
  <add-usecase />
  <remove-usecase />
  <map-component />
  <map-taxonomy />
</div>
</template>

<script>
import {
  EventBus
} from "@/api/event-bus.js";

import Usecases from "@/api/Usecases.js";
import ListUsecase from "@/components/usecase/List";
import AddUsecase from "@/components/usecase/Add";
import EditUsecase from "@/components/usecase/Edit";
import RemoveUsecase from "@/components/usecase/Remove";
import MapComponent from "@/components/usecase/MapComponent";
import MapTaxonomy from "@/components/usecase/MapTaxonomy";

export default {
  name: "usecases",
  props: {
    perPage: {
      default: () => {
        return 10;
      }
    }
  },
  components: {
    "list-usecase": ListUsecase,
    "edit-usecase": EditUsecase,
    "add-usecase": AddUsecase,
    "remove-usecase": RemoveUsecase,
    "map-component": MapComponent,
    "map-taxonomy": MapTaxonomy
  },
  data() {
    return {
        fields: [{
          key: "name",
          label: "Name"
        },
        {
          key: "status",
          label: "Status"
        },
        {
          key: "actions",
          label: "Actions"
        }
      ],
      currentPage: 1,
      totalRows: 0,
      data: []
    };
  },
  computed: {
    isLoggedIn() {
      return this.$store.getters.isLoggedIn;
    },
    isEditOn() {
      return this.$store.getters.isEditOn;
    }
  },
  watch: {
  },
  mounted() {
  },
  methods: {
  }
};
</script>

<style scoped></style>
