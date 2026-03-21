import { projectDetails } from '$lib/data/project-details';
import { error } from '@sveltejs/kit';

export function load({ params }: { params: { slug: string } }) {
  const project = projectDetails[params.slug];

  if (!project) {
    throw error(404, 'Project not found');
  }

  return { project };
}
