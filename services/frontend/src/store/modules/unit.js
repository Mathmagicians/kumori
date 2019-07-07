import Unit from "@/api/Unit";
const state = {
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
  list: state => state.list,
  current: state => state.current,
  editable: state => state.editable,
  query: state => state.list.query
}

const actions = {
  update({
    commit,
    state,
    dispatch
  }) {
    new Unit().update(
      state.current.uid,
      state.current.name,
      state.current.description
    ).then(() => {
      commit('setEditable', false)
      dispatch('search')
    })
  },
  current({
    commit,
    state
  }, data) {
    new Unit().getC(
      0,
      1,
      [],
      [],
      [`uid=eq.${data.id}`]
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
    let ilike = state.list.query !== '' ? `search=ilike.*${encodeURI(state.list.query)}*` : ''
    new Unit().search(
        start,
        stop,
        ['id,name'],
        [],
        [ilike]
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
  setEditable(state, data) {
    state.editable = data;
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
