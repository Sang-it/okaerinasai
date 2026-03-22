<script lang="ts">
</script>

<nav>
	<div class="nav-left">
		<a href="/" class="logo">s<span class="logo-bold">m</span></a>
	</div>
	<div class="nav-right">
		<ul class="nav-links">
			<li><a href="/#projects">Projects</a></li>
			<li><a href="/#skills">Skills</a></li>
			<li><a href="/#experience">Experience</a></li>
			<li><a href="/blog">Blog</a></li>
		</ul>
	</div>
</nav>

<style>
	nav {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 0.75rem 0;
		border-bottom: 1px solid var(--border);
		margin: 0 -2rem 2rem;
		padding-left: 2rem;
		padding-right: 2rem;
		position: sticky;
		top: 0;
		z-index: 100;
		background-color: var(--bg);
	}

	.nav-left {
		display: flex;
		align-items: center;
	}

	.logo {
		font-family: var(--font-mono);
		font-weight: var(--weight-normal);
		font-size: var(--text-lg);
		letter-spacing: -0.02em;
		border-bottom: none;
		color: var(--fg);
	}

	.logo:hover {
		border-bottom: none;
		color: var(--fg);
	}

	.logo-bold {
		font-weight: var(--weight-bold);
	}

	.nav-right {
		display: flex;
		align-items: center;
		gap: 0.5rem;
	}

	.nav-links {
		display: flex;
		list-style: none;
		margin: 0;
		padding: 0;
		gap: 1.25rem;
		margin-right: 1rem;
	}

	.nav-links a {
		font-size: var(--text-sm);
		color: var(--muted);
		border-bottom: none;
	}

	.nav-links a:hover {
		color: var(--fg);
		border-bottom: none;
	}

	.nav-links li {
		list-style: none;
	}

	@media (max-width: 600px) {
		nav {
			flex-wrap: wrap;
			justify-content: center;
			gap: 0.5rem;
		}

		.nav-left {
			flex: 0 0 100%;
			justify-content: center;
			margin-bottom: 0.25rem;
		}

		.nav-right {
			justify-content: center;
			flex-wrap: wrap;
		}

		.nav-links {
			margin-right: 0.5rem;
			gap: 0.75rem;
		}
	}
</style>
