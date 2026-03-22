<script lang="ts">
	import { contributions } from '$lib/data/contributions';

	let sortOrder = $state<'newest' | 'oldest'>('newest');
	let ready = $state(false);

	$effect(() => {
		try {
			const v = localStorage.getItem('sort-contributions');
			if (v === 'oldest') sortOrder = 'oldest';
		} catch {}
		ready = true;
	});

	$effect(() => {
		if (!ready) return;
		try { localStorage.setItem('sort-contributions', sortOrder); } catch {}
	});

	let sortedContributions = $derived(() => {
		return [...contributions].sort((a, b) => {
			const dateA = new Date(a.pr.mergedAt).getTime();
			const dateB = new Date(b.pr.mergedAt).getTime();
			return sortOrder === 'newest' ? dateB - dateA : dateA - dateB;
		});
	});
</script>

<section id="contributions" class="contributions-section">
	<div class="section-header">
		<h2 class="section-title">Contributions</h2>
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
	<div class="contributions-list">
		{#each sortedContributions() as contrib}
			<a href="/contributions/{contrib.slug}" class="contrib-card bordered">
				<div class="contrib-header">
					<div class="contrib-project">
						<span class="contrib-name">{contrib.project}</span>
						<span class="contrib-stars">
							<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
							</svg>
							{contrib.projectStars}
						</span>
					</div>
					<span class="contrib-lang">{contrib.language}</span>
				</div>
				<p class="contrib-project-desc">{contrib.projectDescription}</p>

				<div class="contrib-footer">
					<div class="contrib-pr">
						<span class="pr-badge">{contrib.pr.state}</span>
						<span class="pr-title">{contrib.pr.title}</span>
						<span class="pr-number">#{contrib.pr.number}</span>
					</div>
					<span class="contrib-arrow">&#8599;</span>
				</div>
			</a>
		{/each}
	</div>
	{/if}
</section>

<style>
	.contributions-section {
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

	.contributions-list {
		display: flex;
		flex-direction: column;
		gap: 1rem;
	}

	.contrib-card {
		display: block;
		padding: 1.25rem;
		transition: border-color 0.15s;
		text-decoration: none;
		color: var(--fg);
	}

	.contrib-card:hover {
		border-color: var(--accent);
		border-bottom: 1px solid var(--accent);
	}

	.contrib-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 0.35rem;
	}

	.contrib-project {
		display: flex;
		align-items: center;
		gap: 0.75rem;
	}

	.contrib-name {
		font-weight: var(--weight-bold);
		font-family: var(--font-mono);
	}

	.contrib-stars {
		display: flex;
		align-items: center;
		gap: 0.25rem;
		font-size: var(--text-xs);
		color: var(--muted);
	}

	.contrib-lang {
		font-size: var(--text-xs);
		color: var(--muted);
		font-family: var(--font-mono);
	}

	.contrib-project-desc {
		font-size: var(--text-sm);
		color: var(--muted);
		margin: 0 0 0.75rem;
		line-height: 1.5;
	}

	.contrib-footer {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.contrib-pr {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		flex-wrap: wrap;
	}

	.pr-badge {
		font-size: var(--text-xs);
		font-family: var(--font-mono);
		padding: 0.15rem 0.4rem;
		border: 1px solid var(--border);
		color: var(--fg);
		text-transform: lowercase;
	}

	.pr-title {
		font-size: var(--text-sm);
		font-family: var(--font-mono);
		color: var(--fg);
	}

	.pr-number {
		font-size: var(--text-xs);
		color: var(--muted);
	}

	.contrib-arrow {
		font-size: var(--text-sm);
		color: var(--muted);
		transition: color 0.15s;
	}

	.contrib-card:hover .contrib-arrow {
		color: var(--accent);
	}
</style>
