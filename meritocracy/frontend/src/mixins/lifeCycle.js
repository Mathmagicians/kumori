export default {
	variant : {
      maybe: "secondary",
      buy: "primary", 
      hold: "success",
      sell: "danger"
    },
	filters: {
		outline() {
			return 'outline-';
		}
	},
	computed: {
      types: function() {
        let temp = this.$store.state.lifeCycle.items.map( item => item.type).filter((v, i, a) => a.indexOf(v) === i);
        return temp;

      },
      itemsForType: function() {
        const namesForType = type =>  this.$store.state.lifeCycle.items.filter( item => item.type === type).map( item => item.name);
        const myMap = new Map();
        this.types.forEach( type =>  myMap[type] = namesForType(type));
        return myMap;
      }
    },
    methods: {
    	btnVariant(type){
    		return type?this.$options.variant[type]:'';
      },
      // todo - unit test!
      // returns a list of root elements, that are trees built from parent-child relations in the flatList. Assumes name, parent and no loops.
      // test data: [{"name":"A", parent:"null"},{"name":"B", parent:"A"}, {"name":"C", parent:"A"}, {"name":"D", parent:""}]
      // assert  [ { "name": "A", "parent": "null", "children": [ { "name": "B", "parent": "A", "children": [] }, { "name": "C", "parent": "A", "children": [] } ] }, { "name": "D", "parent": "", "children": [] } ]
      buildTree( flatList ) {
        const nonExists = ( e ) => { return (e=== 'null') || (e=== null) || (e=== undefined) || (e === '') || (e ===[])}
        let tree = [];
        let lookUp = {};

        if( nonExists(flatList) ){
          console.log("Recieved empty flatlist !")
          return tree;
        }

        //we work on a copy to treeify  
        let myCopy = [...flatList];
        
        myCopy.forEach( el => { 
          lookUp[ el.name] = el; 
          el.children = [];
          el.size ="100";
        });

        myCopy.forEach( el => {
          if(  nonExists(el.parent) ){
            //it is a root
            tree.push(el);
          } else {
            lookUp[el.parent].children.push(el);
          }
        });

        return tree;
      },

      buildTreeForSunburst( tree ){
        let treeObj = {name: "#techmenu taxonomy"};
          treeObj.children = tree;
          return treeObj;
      },

      saveFile: function( treeObj ) {
        const data = JSON.stringify(treeObj);
        window.localStorage.setItem('treeObj', data);
        console.log( "saved to local storage as "+ 'treeObj');
      }

    }
}