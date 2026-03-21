<script lang="ts">
	import { skills } from '$lib/data/skills';
</script>

<section id="skills" class="skills-section">
	<h2 class="section-title">Skills</h2>

	<div class="skills-grid">
		{#each skills as category}
			<div class="skill-category bordered">
				<h3 class="skill-category-name">{category.name}</h3>
				<div class="skill-tags">
					{#each category.items as item}
						<span class="skill-tag">{item}</span>
					{/each}
				</div>
			</div>
		{/each}
	</div>
</section>

<style>
	.skills-section {
		padding: 1rem 0;
	}

	.skills-grid {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 1rem;
	}

	.skill-category {
		padding: 1rem 1.25rem;
	}

	.skill-category-name {
		font-size: var(--text-sm);
		font-weight: var(--weight-semibold);
		margin-bottom: 0.75rem;
		color: var(--fg);
		font-family: var(--font-mono);
		text-transform: lowercase;
	}

	.skill-tags {
		display: flex;
		flex-wrap: wrap;
		gap: 0.5rem;
	}

	.skill-tag {
		font-size: var(--text-xs);
		color: var(--muted);
		padding: 0.2rem 0.5rem;
		border: 1px solid var(--border);
		font-family: var(--font-mono);
		transition: border-color 0.15s, color 0.15s;
	}

	.skill-tag:hover {
		border-color: var(--accent);
		color: var(--fg);
	}

	@media (max-width: 600px) {
		.skills-grid {
			grid-template-columns: 1fr;
		}
	}
</style>
