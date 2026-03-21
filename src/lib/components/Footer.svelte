<script lang="ts">
	import { hero } from '$lib/data/hero';
	import { contacts } from '$lib/data/contacts';
</script>
<footer>
	<div class="footer-links-row">
		<a href={contacts.github} target="_blank" rel="noopener noreferrer" class="footer-link-box">GitHub</a>
		<a href={contacts.email} class="footer-link-box">Email</a>
		<a href={contacts.linkedin} target="_blank" rel="noopener noreferrer" class="footer-link-box">LinkedIn</a>
		<a href="/blog" class="footer-link-box">Blog</a>
	</div>
	<div class="footer-bottom">
		<span>&copy; {new Date().getFullYear()} {hero.firstName} {hero.lastName}</span>
	</div>
</footer>

<style>
	footer {
		padding-bottom: 0;
	}

	.footer-links-row {
		display: grid;
		grid-template-columns: repeat(4, 1fr);
		border: 1px solid var(--border);
	}

	.footer-link-box {
		padding: 1rem;
		text-align: center;
		font-family: var(--font-mono);
		font-size: var(--text-sm);
		color: var(--fg);
		border-right: 1px solid var(--border);
		transition: color 0.15s;
	}

	.footer-link-box:last-child {
		border-right: none;
	}

	.footer-link-box:hover {
		color: var(--accent);
	}

	.footer-bottom {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 1rem 0;
		font-size: var(--text-xs);
		color: var(--muted);
	}

	@media (max-width: 600px) {
		.footer-links-row {
			grid-template-columns: repeat(2, 1fr);
		}

		.footer-link-box {
			border-bottom: 1px solid var(--border);
		}

		.footer-link-box:nth-child(2n) {
			border-right: none;
		}

		.footer-link-box:nth-last-child(-n+2) {
			border-bottom: none;
		}

		.footer-bottom {
			flex-direction: column;
			gap: 0.5rem;
			text-align: center;
		}
	}
</style>
