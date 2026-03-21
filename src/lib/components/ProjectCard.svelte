<script lang="ts">
	import type { Project } from '$lib/data/projects';
	import { projectDetails } from '$lib/data/project-details';

	let { project }: { project: Project } = $props();

	const hasDetail = project.name in projectDetails;
	const href = hasDetail ? `/projects/${project.name}` : project.url;
	const external = !hasDetail;
</script>

<a {href} target={external ? '_blank' : undefined} rel={external ? 'noopener noreferrer' : undefined} class="project-card bordered" class:featured={project.featured}>
	<div class="card-header">
		<span class="card-name">{project.name}</span>
		{#if project.stars && project.stars > 0}
			<span class="card-stars">
				<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
				</svg>
				{project.stars}
			</span>
		{/if}
	</div>
	<p class="card-desc">{project.description}</p>
	<div class="card-footer">
		<span class="card-lang">{project.language}</span>
		<span class="card-arrow">&#8599;</span>
	</div>
</a>

<style>
	.project-card {
		display: flex;
		flex-direction: column;
		padding: 1rem 1.25rem;
		transition: border-color 0.15s;
		border-bottom: 1px solid var(--border);
		cursor: pointer;
		text-decoration: none;
		color: var(--fg);
	}

	.project-card:hover {
		border-color: var(--accent);
		color: var(--fg);
	}

	.card-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 0.5rem;
	}

	.card-name {
		font-weight: var(--weight-bold);
		font-size: var(--text-base);
		font-family: var(--font-mono);
	}

	.project-card:hover .card-name {
		color: var(--accent);
	}

	.card-stars {
		display: flex;
		align-items: center;
		gap: 0.25rem;
		font-size: var(--text-xs);
		color: var(--muted);
	}

	.card-desc {
		font-size: var(--text-sm);
		color: var(--muted);
		line-height: 1.5;
		flex: 1;
		margin: 0;
	}

	.card-footer {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-top: 0.75rem;
	}

	.card-lang {
		font-size: var(--text-xs);
		color: var(--muted);
		font-family: var(--font-mono);
	}

	.card-arrow {
		font-size: var(--text-sm);
		color: var(--muted);
		transition: color 0.15s;
	}

	.project-card:hover .card-arrow {
		color: var(--accent);
	}
</style>
