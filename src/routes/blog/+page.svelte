<script lang="ts">
	let { data } = $props();

	let query = $state('');
	let sortOrder = $state<'newest' | 'oldest'>('newest');

	let filteredPosts = $derived(() => {
		const q = query.toLowerCase().trim();

		let posts = data.posts.filter((post) => {
			if (!q) return true;
			const title = post.metadata.title?.toLowerCase() ?? '';
			// fuzzy match: check if all characters appear in order
			let ti = 0;
			for (let qi = 0; qi < q.length; qi++) {
				const idx = title.indexOf(q[qi], ti);
				if (idx === -1) return false;
				ti = idx + 1;
			}
			return true;
		});

		posts.sort((a, b) => {
			const dateA = new Date(a.metadata.date || '').getTime();
			const dateB = new Date(b.metadata.date || '').getTime();
			return sortOrder === 'newest' ? dateB - dateA : dateA - dateB;
		});

		return posts;
	});
</script>

<svelte:head>
	<title>Blog - Sangit Manandhar</title>
</svelte:head>

<section class="blog-page">
	<h1 class="section-title">Blog</h1>

	<div class="blog-controls">
		<input
			type="text"
			class="search-input"
			placeholder="Search posts..."
			bind:value={query}
		/>
		<button
			class="sort-btn"
			onclick={() => sortOrder = sortOrder === 'newest' ? 'oldest' : 'newest'}
		>
			{sortOrder === 'newest' ? 'Newest first' : 'Oldest first'}
		</button>
	</div>

	{#if data.posts.length === 0}
		<p class="subtext">No posts yet. Check back soon.</p>
	{:else if filteredPosts().length === 0}
		<p class="subtext">No posts matching "{query}"</p>
	{:else}
		<div class="posts-list">
			{#each filteredPosts() as post}
				<a href="/blog/{post.path}" class="post-card bordered">
					<div class="post-header">
						<span class="post-title">{post.metadata.title}</span>
						<span class="post-date subtext">{post.metadata.date}</span>
					</div>
					{#if post.metadata.description}
						<p class="post-desc subtext">{post.metadata.description}</p>
					{/if}
				</a>
			{/each}
		</div>
	{/if}
</section>

<style>
	.blog-page {
		padding: 2rem 0;
	}

	.blog-controls {
		display: flex;
		gap: 0.75rem;
		margin-bottom: 1.5rem;
	}

	.search-input {
		flex: 1;
		padding: 0.5rem 0.75rem;
		background: var(--card-bg);
		border: 1px solid var(--border);
		color: var(--fg);
		font-family: var(--font-mono);
		font-size: var(--text-sm);
		outline: none;
		border-radius: 0;
	}

	.search-input::placeholder {
		color: var(--muted);
	}

	.search-input:focus {
		border-color: var(--fg);
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

	.posts-list {
		display: flex;
		flex-direction: column;
		gap: 0;
	}

	.post-card {
		display: block;
		padding: 1rem 1.25rem;
		transition: border-color 0.15s;
		text-decoration: none;
		color: var(--fg);
		border-bottom: 1px solid var(--border);
	}

	.post-card:hover {
		border-color: var(--accent);
	}

	.post-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.post-title {
		font-weight: var(--weight-bold);
		font-family: var(--font-mono);
	}

	.post-card:hover .post-title {
		color: var(--accent);
	}

	.post-date {
		font-size: var(--text-xs);
		font-family: var(--font-mono);
	}

	.post-desc {
		margin-top: 0.25rem;
		font-size: var(--text-sm);
	}

	@media (max-width: 600px) {
		.blog-controls {
			flex-direction: column;
		}
	}
</style>
