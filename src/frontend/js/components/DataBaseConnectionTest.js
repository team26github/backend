import * as test from "../dbconnect.js"

export default {
    template: `
        <!-- Shorthand for "v-bind:..." -> :... -->
        <!-- Shorthand for "v-on:..." -> @... -->
        <button :class="button_class" :disabled="clicked" @click="button_click" @click="test_connection">
            <slot />
        </button>
    `,

    data() {
        return {
            clicked: false,
            button_class: 'not-clicked'
        };
    },

    methods: {
        button_click() {
            this.button_class = 'clicked';
            this.clicked = true;
            test.connect();
        },

        test_connection(){
            axios({
              url: 'http://localhost:5000/',
              method: 'get'
            })
            .then(res => {
              console.log(res)
              this.records = res.data.catalog_list
            })
            .catch(err => {
              console.log(err)
            })
        }
    }
}