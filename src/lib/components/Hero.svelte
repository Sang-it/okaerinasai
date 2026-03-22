<script lang="ts">
	import { hero } from '$lib/data/hero';
</script>
<section class="hero">
	<p class="hero-greeting">{hero.greeting}</p>
	<h1 class="hero-name">
		<span class="name-first">{hero.firstName}</span> <span class="name-last">{hero.lastName}</span>
	</h1>
	<p class="hero-sub subtext">I use neovim and dvorak btw.</p>
</section>

<style>
	.hero {
		text-align: left;
		padding: 5rem 0 2rem;
	}

	.hero-greeting {
		font-size: var(--text-sm);
		color: var(--muted);
		margin-bottom: 0.5rem;
		font-family: var(--font-mono);
	}

	.hero-name {
		font-size: clamp(2.5rem, 5vw, 4rem);
		font-weight: var(--weight-bold);
		font-family: var(--font-mono);
		margin: 0.25rem 0;
		letter-spacing: -0.03em;
		line-height: 1.1;
	}


	.hero-title {
		font-size: var(--text-lg);
		font-weight: var(--weight-normal);
		font-family: var(--font-mono);
		color: var(--muted);
		margin: 0.75rem 0;
	}

	.hero-sub {
		line-height: 1.6;
	}

	@media (max-width: 600px) {
		.hero {
			padding: 3rem 0 1.5rem;
		}

		.hero-name {
			font-size: var(--text-2xl);
		}
	}
</style>
