import '../css/app.css';

import { createInertiaApp } from '@inertiajs/vue3';
import Aura from '@primeuix/themes/aura';
import PrimeVue from 'primevue/config';
import { createApp, h, type DefineComponent } from 'vue';

// Everything the browser loads is bundled by Vite and served by the application:
// no font, script, style or icon comes from a third-party host (specs/02-architecture.md §5, D-018).
const pages = import.meta.glob<DefineComponent>('./Pages/**/*.vue');

createInertiaApp({
    resolve: async (name) => {
        const page = pages[`./Pages/${name}.vue`];
        if (!page) {
            throw new Error(`Unknown Inertia page: ${name}`);
        }
        return page();
    },
    setup({ el, App, props, plugin }) {
        createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(PrimeVue, {
                theme: {
                    preset: Aura,
                    options: {
                        // Tailwind utilities win over PrimeVue's styles (layer order in app.css).
                        cssLayer: { name: 'primevue', order: 'theme, base, primevue, components, utilities' },
                    },
                },
            })
            .mount(el);
    },
});
