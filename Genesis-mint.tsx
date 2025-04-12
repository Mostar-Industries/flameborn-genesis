import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useState } from "react";
import { motion } from "framer-motion";

export default function FlamebornLanding() {
  const [email, setEmail] = useState("");
  const handleSignup = () => {
    console.log("User email:", email);
    // This would be connected to Supabase function later
  };

  return (
    <div className="min-h-screen bg-black text-white p-4 grid place-items-center">
      <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 1 }} className="max-w-2xl w-full">
        <h1 className="text-4xl font-bold text-center mb-6">FLAMEBORN</h1>
        <p className="text-center text-lg mb-6 italic">Life is Simple. Only Decide.</p>

        <Card className="bg-gray-900 border border-gray-700">
          <CardContent className="space-y-4">
            <h2 className="text-xl font-semibold">🌍 Mission</h2>
            <p>We are not responding to crises. We are eradicating them. Flameborn is a life-saving token project funding real-time eradication of diseases in Africa through direct empowerment, AI tools, and blockchain transparency.</p>

            <h2 className="text-xl font-semibold">🔥 Genesis Token Drop</h2>
            <p>100 Flameborn Genesis Tokens will grant holders:</p>
            <ul className="list-disc list-inside">
              <li>Governance rights in the Flameborn DAO</li>
              <li>Access to Mostar AI for impact ops</li>
              <li>Proof of Eradication Contribution</li>
            </ul>

            <h2 className="text-xl font-semibold">🕯️ Be First</h2>
            <p>Sign up to be among the first Flameborn and change the narrative of health injustice across the continent.</p>
            <div className="flex gap-2">
              <Input 
                type="email" 
                placeholder="your@email.com" 
                value={email} 
                onChange={(e) => setEmail(e.target.value)} 
                className="text-black"
              />
              <Button onClick={handleSignup}>Join</Button>
            </div>
          </CardContent>
        </Card>
      </motion.div>
    </div>
  );
}
