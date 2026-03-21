<script lang="ts">
	import ProjectCard from './ProjectCard.svelte';
	import { projects } from '$lib/data/projects';
</script>

<section id="projects" class="projects-section">
	<h2 class="section-title">Projects</h2>

	<div class="projects-grid">
		{#each projects as project}
			<ProjectCard {project} />
		{/each}
	</div>
</section>

<style>
	.projects-section {
		padding: 1rem 0;
	}

	.projects-grid {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 1rem;
	}

	.other-label {
		margin: 2rem 0 0.75rem;
		text-align: left;
		font-size: var(--text-sm);
	}

	@media (max-width: 600px) {
		.projects-grid {
			grid-template-columns: 1fr;
		}
	}
</style>
