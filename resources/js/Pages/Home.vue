<script setup lang="ts">
import { Head } from '@inertiajs/vue3';
import Tag from 'primevue/tag';

defineProps<{
    appName: string;
    tagline: string;
}>();
</script>

<template>
    <Head :title="appName" />
    <main class="mx-auto flex min-h-screen max-w-2xl flex-col justify-center gap-4 p-6">
        <h1 class="text-3xl font-semibold text-gray-900">{{ appName }}</h1>
        <p class="text-gray-700">{{ tagline }}</p>
        <div>
            <Tag value="FND-01" severity="secondary" />
        </div>
    </main>
</template>
