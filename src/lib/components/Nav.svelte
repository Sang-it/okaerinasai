<script lang="ts">
	import ThemeToggle from './ThemeToggle.svelte';
	import {contacts} from '$lib/data/contacts';
</script>

<nav>
	<div class="nav-left">
		<a href="/">SM</a>
	</div>
	<div class="nav-right">
		<ul class="nav-links">
			<a href="/#projects"><li>Projects</li></a>
			<a href="/#skills"><li>Skills</li></a>
			<a href="/#experience"><li>Experience</li></a>
			<a href="/blog"><li>Blog</li></a>
			<a href="/#contact"><li>Contact</li></a>
		</ul>
		<div class="nav-icons">
			<a
				href={contacts.github}
				class="icon-btn"
				aria-label="GitHub"
				target="_blank"
				rel="noopener noreferrer"
			>
				<svg
					width="20"
					height="20"
					viewBox="0 0 24 24"
					fill="currentColor"
					aria-hidden="true"
				>
					<path
						d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0024 12c0-6.63-5.37-12-12-12z"
					/>
				</svg>
			</a>
			<ThemeToggle />
		</div>
	</div>
</nav>

<style>
	nav {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 0.5em 1rem;
		border-bottom: 1px solid var(--border);
		margin-bottom: 2rem;
		flex-wrap: wrap;
		gap: 0.5rem;
		position: sticky;
		top: 0;
		z-index: 100;
		background-color: var(--bg);
	}

	.nav-left {
		display: flex;
		align-items: center;
	}

	.nav-left a {
		font-family: var(--font-sans);
		font-weight: var(--weight-bold);
		font-size: var(--text-lg);
		letter-spacing: -0.03em;
		border-bottom: none;
	}

	.nav-left a:hover {
		border-bottom: none;
	}

	.nav-right {
		display: flex;
		align-items: center;
		flex-wrap: wrap;
		gap: 0.5rem;
	}

	.nav-links {
		display: flex;
		flex-wrap: wrap;
		list-style: none;
		margin: 0;
		padding: 0;
		gap: 1rem;
		margin-right: 1rem;
	}

	.nav-links a {
		font-size: var(--text-sm);
		border-bottom: none;
	}

	.nav-links li {
		list-style: none;
	}

	.nav-icons {
		display: flex;
		align-items: center;
		gap: 0.25rem;
	}

	.icon-btn {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		padding: 0.35rem;
		border: none;
		background: none;
		cursor: pointer;
		transition: opacity 0.2s;
		border-bottom: none;
		color: var(--fg);
	}

	.icon-btn:hover {
		opacity: 0.7;
		border-bottom: none;
		color: var(--accent);
	}

	@media (max-width: 600px) {
		nav {
			justify-content: center;
		}

		.nav-left {
			flex: 0 0 100%;
			justify-content: center;
			margin-bottom: 0.25rem;
		}

		.nav-right {
			justify-content: center;
		}

		.nav-links {
			margin-right: 0.5rem;
			gap: 0.75rem;
		}
	}
</style>
