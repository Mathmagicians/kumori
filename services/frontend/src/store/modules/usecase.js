import Usecase from "@/api/Usecase";
const state = {
  showAddUsecase: false,
  showEditUsecase: false,
  showRemoveUsecase: false,
  showCreateUsecaseComponentMap: false,
  showCreateUsecaseTaxonomyMap: false,
  deleteable: false,
  editable: false,
  current: {},
  list: {
    fields: [{
      key: "name",
      label: "Name"
    }],
    busy: true,
    query: '',
    data: [],
    currentPage: 1,
    perPage: 10,
    totalRows: 0
  }
}

const getters = {
  showAddUsecase: state => state.showAddUsecase,
  showEditUsecase: state => state.showEditUsecase,
  showRemoveUsecase: state => state.showRemoveUsecase,
  showCreateUsecaseComponentMap: state => state.showCreateUsecaseComponentMap,
  showCreateUsecaseTaxonomyMap: state => state.showCreateUsecaseTaxonomyMap,
  list: state => state.list,
  current: state => state.current,
  editable: state => state.editable,
  query: state => state.list.query
}

const actions = {
  remove({
    commit,
    state,
    dispatch
  }) {
    new Usecase().deleteById(
      state.current.id
    ).then(() => {
      state.current = {}
      dispatch('search')
    })
  },
  update({
    commit,
    state,
    dispatch
  }) {
    new Usecase().update(
      state.current.id,
      state.current.name,
      state.current.description
    ).then(() => {
      dispatch('search')
    })
  },
  current({
    commit,
    state
  }, data) {
    new Usecase().get(
      0,
      1,
      [],
      [],
      [`id=eq.${data.id}`]
    ).then(result => {
      state.current = result.data[0]
    })
  },
  search({
    state
  }) {
    state.list.busy = true
    let start = state.list.currentPage === 1 ? 0 : (state.list.currentPage - 1) * state.list.perPage;
    let stop = state.list.currentPage === 1 ? (state.list.currentPage * state.list.perPage) - 1 : (state.list.currentPage * state.list.perPage)

    new Usecase().get(
        start,
        stop,
        [],
        ["id.desc"],
        []
      )
      .then(response => {
        state.list.data = response.data
        state.list.totalRows = parseInt(response.total);
        state.list.busy = false
      })
      .catch(error => {
        console.log(error)
      });
  },
}

const mutations = {
  toggleAddUsecase(state) {
    if (state.showAddUsecase) {
      state.showAddUsecase = false;
    } else {
      state.showAddUsecase = true;
    }
  },
  toggleEditUsecase(state) {
    if (state.showEditUsecase) {
      state.showEditUsecase = false;
    } else {
      state.showEditUsecase = true;
    }
  },
  toggleRemoveUsecase(state) {
    if (state.showRemoveUsecase) {
      state.showRemoveUsecase = false;
    } else {
      state.showRemoveUsecase = true;
    }
  },
  toggleCreateUsecaseComponentMap(state) {
    if (state.showCreateUsecaseComponentMap) {
      state.showCreateUsecaseComponentMap = false;
    } else {
      state.showCreateUsecaseComponentMap = true;
    }
  },
  toggleCreateUsecaseTaxonomyMap(state) {
    if (state.showCreateUsecaseTaxonomyMap) {
      state.showCreateUsecaseTaxonomyMap = false;
    } else {
      state.showCreateUsecaseTaxonomyMap = true;
    }
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
