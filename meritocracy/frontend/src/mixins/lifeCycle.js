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
      // returns a list of root elements, that are trees built from parent-child relations in the flatList. Assumes name, parent and no loops.
      buildTree( flatList ) {
        console.log("flat list is: ");
        console.log( flatList);
        const exists = ( e ) => { return (e=== 'null') || (e=== undefined) || (e === '') }
        const findChildren = ( parent, list) => {
          return list.filter( e => {return e.parent === parent.name });
        };

        const findRoots = ( list ) => {
          return list.filter( e=> { return !exists(e.parent) }); 
        };
        let tree = findRoots( flatList );
        console.log( "roots" + tree );
        return tree;
      }

    }
}