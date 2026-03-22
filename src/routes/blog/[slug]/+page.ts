import { error } from '@sveltejs/kit';

export function entries() {
	const modules = import.meta.glob('/src/content/blog/*.md', { eager: true });
	return Object.keys(modules).map((path) => ({
		slug: path.split('/').pop()?.replace('.md', '') ?? ''
	}));
}

export async function load({ params }: { params: { slug: string } }) {
	try {
		const post = await import(`../../../content/blog/${params.slug}.md`);
		return {
			content: post.default,
			metadata: post.metadata as Record<string, string>
		};
	} catch {
		throw error(404, `Post not found: ${params.slug}`);
	}
}
