<script lang="ts">
	import { hero } from '$lib/data/hero';
	import { contacts } from '$lib/data/contacts';
</script>
<footer>
	<hr class="section-divider" />
	<div class="footer-content">
		<p class="subtext">&copy; {new Date().getFullYear()} {hero.firstName} {hero.lastName}</p>
		<div class="footer-links">
			<a href={contacts.github} target="_blank" rel="noopener noreferrer">GitHub</a>
		</div>
	</div>
</footer>

<style>
	footer {
		padding-bottom: 2rem;
	}

	.footer-content {
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size: var(--text-sm);
	}

	.footer-links {
		display: flex;
		gap: 1rem;
	}

	@media (max-width: 600px) {
		.footer-content {
			flex-direction: column;
			gap: 0.5rem;
			text-align: center;
		}
	}
</style>
