<script lang="ts">
	import ProjectCard from './ProjectCard.svelte';
	import { projects } from '$lib/data/projects';

	const featured = projects.filter((p) => p.featured);
	const other = projects.filter((p) => !p.featured);
</script>

<section id="projects" class="projects-section">
	<h2 class="section-title">Projects</h2>

	<div class="projects-grid">
		{#each featured as project}
			<ProjectCard {project} />
		{/each}
	</div>

	{#if other.length > 0}
		<p class="other-label subtext">Other projects</p>
		<div class="projects-grid">
			{#each other as project}
				<ProjectCard {project} />
			{/each}
		</div>
	{/if}
</section>

<style>
	.projects-section {
		padding: 1rem 0;
	}

	.projects-grid {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 0;
	}

	.other-label {
		margin: 2rem 0 0.75rem;
		text-align: center;
		font-size: var(--text-sm);
	}

	@media (max-width: 600px) {
		.projects-grid {
			grid-template-columns: 1fr;
		}
	}
</style>
