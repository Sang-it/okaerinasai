import { contributions } from '$lib/data/contributions';
import { error } from '@sveltejs/kit';

export function entries() {
  return contributions.map((c) => ({ slug: c.slug }));
}

export function load({ params }: { params: { slug: string } }) {
  const contribution = contributions.find((c) => c.slug === params.slug);

  if (!contribution) {
    throw error(404, 'Contribution not found');
  }

  return { contribution };
}
