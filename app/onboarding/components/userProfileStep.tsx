'use client';

import { useTransition } from 'react';
import { updateOnboardingStep } from '../action';


export default function UserProfileStep() {
  const [isPending, startTransition] = useTransition();

  // const handleNext = async () => {
  //   startTransition(async () => {
  //     await updateOnboardingStep('STARTUP_INFO');
  //     // Client-side refresh om nieuwe step te laden
  //     window.location.reload();
  //   });
  // };

  return (
    <div>
      <h1>Complete je profiel</h1>
      {/* Form hier */}
      <button disabled={isPending} onClick={() => console.log("tr")}>
        Volgende
      </button>
    </div>
  );
}
