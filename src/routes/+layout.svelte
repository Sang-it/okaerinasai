<script lang="ts">
	import '../app.css';
	import Nav from '$lib/components/Nav.svelte';
	import Footer from '$lib/components/Footer.svelte';

	let { children } = $props();
</script>

<svelte:head>
	<title>Sangit Manandhar</title>
</svelte:head>

<div class="page-box">
	<Nav />
	<main>
		{@render children()}
	</main>
</div>
<Footer />

<style>
	.page-box {
		border-left: 1px solid var(--border);
		border-right: 1px solid var(--border);
		padding: 0 2rem 3rem;
		min-height: calc(100vh - 6rem);
	}

	main {
		min-height: calc(100vh - 14rem);
	}
</style>
