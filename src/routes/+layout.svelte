<script lang="ts">
	import '../app.css';
	import Nav from '$lib/components/Nav.svelte';
	import Footer from '$lib/components/Footer.svelte';

	let { children } = $props();
</script>

<svelte:head>
	<title>Sangit Manandhar</title>
</svelte:head>

<Nav />
<main>
	{@render children()}
</main>
<Footer />

<style>
	main {
		min-height: calc(100vh - 10rem);
	}
</style>
