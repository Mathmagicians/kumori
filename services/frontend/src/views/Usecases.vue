<template>
<b-container fluid>
  <b-row>
    <b-col>
      <list-usecase />
    </b-col>
    <b-col>
      <show-usecase />
    </b-col>
  </b-row>
  <edit-usecase />
  <add-usecase />
  <remove-usecase />
  <map-component />
  <map-taxonomy />
</b-container>
</template>
<script>
import {
  EventBus
} from "@/api/event-bus.js";
import {
  mapGetters
} from 'vuex'
import Usecases from "@/api/Usecases.js";
import ListUsecase from "@/components/usecase/List";
import ShowUsecase from "@/components/usecase/Show";
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
    "show-usecase": ShowUsecase,
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
    ...mapGetters([
      'readonly'
    ])
  },
  watch: {},
  mounted() {},
  methods: {}
};
</script>

<style scoped></style>
