import { projectDetails } from '$lib/data/project-details';
import { error } from '@sveltejs/kit';

export function entries() {
  return Object.keys(projectDetails).map((slug) => ({ slug }));
}

export function load({ params }: { params: { slug: string } }) {
  const project = projectDetails[params.slug];

  if (!project) {
    throw error(404, 'Project not found');
  }

  return { project };
}
