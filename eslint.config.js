import js from '@eslint/js';
import prettier from 'eslint-config-prettier';
import vue from 'eslint-plugin-vue';
import globals from 'globals';
import tseslint from 'typescript-eslint';

// D-006: ESLint with the Vue and TypeScript configs; Prettier owns formatting,
// so every stylistic rule it would fight is switched off last.
export default tseslint.config(
    {
        ignores: ['vendor/**', 'node_modules/**', 'public/**', 'bootstrap/ssr/**', 'storage/**'],
    },
    js.configs.recommended,
    ...tseslint.configs.recommended,
    ...vue.configs['flat/recommended'],
    {
        files: ['**/*.vue'],
        languageOptions: {
            parserOptions: {
                parser: tseslint.parser,
            },
        },
    },
    {
        // Inertia page names mirror controller names (specs/02-architecture.md §1).
        files: ['resources/js/Pages/**/*.vue'],
        rules: {
            'vue/multi-word-component-names': 'off',
        },
    },
    {
        languageOptions: {
            globals: { ...globals.browser },
        },
    },
    {
        files: ['vite.config.ts', 'eslint.config.js'],
        languageOptions: {
            globals: { ...globals.node },
        },
    },
    prettier,
);
