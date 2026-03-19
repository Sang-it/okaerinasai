<script lang="ts">
	import { hero } from '$lib/data/hero';
</script>
<section class="hero">
	<p class="hero-greeting">{hero.greeting}</p>
	<h1 class="hero-name">
		<span class="name-first">{hero.firstName}</span> <span class="name-last">{hero.lastName}</span>
	</h1>
	<p class="hero-title">{hero.title}</p>
	<p class="hero-sub subtext">{hero.summary} </p>
</section>

<style>
	.hero {
		text-align: center;
		padding: 4rem 0 2rem;
	}

	.hero-greeting {
		font-size: var(--text-sm);
		color: var(--accent);
		margin-bottom: 0.5rem;
		font-family: var(--font-mono);
	}

	.hero-name {
		font-size: var(--text-4xl);
		font-weight: var(--weight-bold);
		margin: 0.25rem 0;
		letter-spacing: -0.03em;
	}

	.name-first {
		display: inline-block;
		animation: slideIn 0.6s ease-out forwards;
	}

	.name-last {
		display: inline-block;
		animation: slideIn 0.6s ease-out 0.1s forwards;
		opacity: 0;
	}

	@keyframes slideIn {
		from {
			opacity: 0;
			transform: translateY(10px);
		}
		to {
			opacity: 1;
			transform: translateY(0);
		}
	}

	.hero-title {
		font-size: var(--text-lg);
		font-weight: var(--weight-semibold);
		margin: 0.5rem 0;
		font-family: var(--font-sans);
	}

	.hero-sub {
		max-width: 500px;
		margin: 0.75rem auto 0;
		line-height: 1.5;
	}

	@media (max-width: 600px) {
		.hero {
			padding: 2.5rem 0 1.5rem;
		}

		.hero-name {
			font-size: var(--text-2xl);
		}
	}
</style>
