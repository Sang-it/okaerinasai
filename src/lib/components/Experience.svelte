<script lang="ts">
	import { experiences } from '$lib/data/experiences';
</script>

<section id="experience" class="experience-section">
	<h2 class="section-title">Experience</h2>
	<div class="timeline">
		{#each experiences as experience}
			<div class="timeline-item bordered">
				<div class="timeline-header">
					<span class="timeline-role">{experience.role}</span>
					<span class="timeline-date subtext">{experience.timeline}</span>
				</div>
				<p class="timeline-company">{experience.company}</p>
				<p class="timeline-desc subtext">{experience.description} </p>
			</div>
		{/each}
	</div>
</section>

<style>
	.experience-section {
		padding: 1rem 0;
	}

	.timeline {
		display: flex;
		flex-direction: column;
		gap: 0;
	}

	.timeline-item {
		padding: 1rem 1.25rem;
		transition: border-color 0.15s;
	}

	.timeline-item:hover {
		border-color: var(--accent);
	}

	.timeline-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 0.25rem;
	}

	.timeline-role {
		font-weight: var(--weight-bold);
		font-family: var(--font-mono);
		font-size: var(--text-base);
	}

	.timeline-date {
		font-size: var(--text-xs);
		font-family: var(--font-mono);
	}

	.timeline-company {
		font-size: var(--text-sm);
		color: var(--muted);
		margin: 0;
		font-family: var(--font-mono);
	}

	.timeline-desc {
		font-size: var(--text-sm);
		margin-top: 0.5rem;
		line-height: 1.5;
	}
</style>
