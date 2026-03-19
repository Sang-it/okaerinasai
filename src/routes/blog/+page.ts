export async function load() {
	const posts: { path: string; metadata: Record<string, string> }[] = [];

	const modules = import.meta.glob('/src/content/blog/*.md', { eager: true });

	for (const [path, module] of Object.entries(modules)) {
		const m = module as { metadata: Record<string, string> };
		const slug = path.split('/').pop()?.replace('.md', '') ?? '';
		posts.push({
			path: slug,
			metadata: m.metadata
		});
	}

	posts.sort((a, b) => {
		const dateA = new Date(a.metadata.date || '');
		const dateB = new Date(b.metadata.date || '');
		return dateB.getTime() - dateA.getTime();
	});

	return { posts };
}
