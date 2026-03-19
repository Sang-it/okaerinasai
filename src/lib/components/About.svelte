<script lang="ts">
	import { about } from '$lib/data/about';
</script>
<section id="about" class="about-section">
	<h2 class="section-title">About</h2>
	<div class="about-content">
		{#each about as section}
			<p>	{section} </p>
		{/each}
	</div>
</section>

<style>
	.about-section {
		padding: 1rem 0;
	}

	.about-content {
		width: 85%;
		margin: 0 auto;
	}

	.about-content p {
		color: var(--muted);
		font-size: var(--text-sm);
		line-height: 1.7;
		margin-bottom: 1rem;
		text-align: justify;
		hyphens: auto;
	}

	@media (max-width: 600px) {
		.about-content {
			width: 100%;
		}
	}
</style>
