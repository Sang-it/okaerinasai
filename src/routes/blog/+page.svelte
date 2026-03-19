<script lang="ts">
	let { data } = $props();
</script>

<svelte:head>
	<title>Blog - Sangit Manandhar</title>
</svelte:head>

<section class="blog-page">
	<h1 class="section-title">Blog</h1>

	{#if data.posts.length === 0}
		<p class="subtext" style="text-align: center;">No posts yet. Check back soon.</p>
	{:else}
		<div class="posts-list">
			{#each data.posts as post}
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

	.posts-list {
		display: flex;
		flex-direction: column;
		gap: 0.75rem;
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
		font-family: var(--font-sans);
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
</style>
