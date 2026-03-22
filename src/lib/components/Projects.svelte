<script lang="ts">
	import ProjectCard from './ProjectCard.svelte';
	import { projects } from '$lib/data/projects';

	let sortOrder = $state<'newest' | 'oldest'>('newest');
	let ready = $state(false);

	$effect(() => {
		try {
			const v = localStorage.getItem('sort-projects');
			if (v === 'oldest') sortOrder = 'oldest';
		} catch {}
		ready = true;
	});

	$effect(() => {
		if (!ready) return;
		try { localStorage.setItem('sort-projects', sortOrder); } catch {}
	});

	let sortedProjects = $derived(() => {
		return [...projects].sort((a, b) => {
			const dateA = new Date(a.createdAt).getTime();
			const dateB = new Date(b.createdAt).getTime();
			return sortOrder === 'newest' ? dateB - dateA : dateA - dateB;
		});
	});
</script>

<section id="projects" class="projects-section">
	<div class="section-header">
		<h2 class="section-title">Projects</h2>
		{#if ready}
		<button
			class="sort-btn"
			onclick={() => sortOrder = sortOrder === 'newest' ? 'oldest' : 'newest'}
		>
			{sortOrder === 'newest' ? 'Newest first' : 'Oldest first'}
		</button>
		{/if}
	</div>

	{#if ready}
	<div class="projects-grid">
		{#each sortedProjects() as project}
			<ProjectCard {project} />
		{/each}
	</div>
	{/if}
</section>

<style>
	.projects-section {
		padding: 1rem 0;
	}

	.section-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 1.5rem;
	}

	.section-header .section-title {
		margin-bottom: 0;
	}

	.sort-btn {
		padding: 0.5rem 0.75rem;
		background: var(--card-bg);
		border: 1px solid var(--border);
		color: var(--muted);
		font-family: var(--font-mono);
		font-size: var(--text-sm);
		cursor: pointer;
		white-space: nowrap;
		border-radius: 0;
		transition: border-color 0.15s, color 0.15s;
	}

	.sort-btn:hover {
		border-color: var(--fg);
		color: var(--fg);
	}

	.projects-grid {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 1rem;
	}

	@media (max-width: 600px) {
		.projects-grid {
			grid-template-columns: 1fr;
		}
	}
</style>
