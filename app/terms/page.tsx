"use client"

import { Navigation } from "@/components/navigation"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { FileText, ArrowLeft } from "lucide-react"
import Link from "next/link"
import { Button } from "@/components/ui/button"

export default function TermsPage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <Navigation variant="minimal" />
      <div className="container mx-auto px-4 py-12 max-w-4xl">
        <div className="mb-6">
          <Button variant="ghost" asChild className="mb-4">
            <Link href="/register" className="flex items-center">
              <ArrowLeft className="mr-2 h-4 w-4" />
              Back to Registration
            </Link>
          </Button>
        </div>

        <Card className="border-slate-200 dark:border-slate-700">
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-3xl">
              <FileText className="h-6 w-6" />
              Terms of Service
            </CardTitle>
            <CardDescription>Last updated: {new Date().toLocaleDateString()}</CardDescription>
          </CardHeader>
          <CardContent className="prose dark:prose-invert max-w-none">
            <div className="space-y-6 text-slate-700 dark:text-slate-300">
              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">1. Acceptance of Terms</h2>
                <p>
                  By accessing and using BuildMate ("the Service"), you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.
                </p>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">2. Description of Service</h2>
                <p>
                  BuildMate is a PC building platform that provides tools and resources to help users design, configure, and save custom PC builds. Our services include:
                </p>
                <ul className="list-disc pl-6 space-y-2">
                  <li>PC component compatibility checking</li>
                  <li>Build configuration and saving</li>
                  <li>Community build sharing and browsing</li>
                  <li>Build guides and educational content</li>
                  <li>Component comparison tools</li>
                </ul>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">3. User Accounts</h2>
                <h3 className="text-xl font-semibold text-slate-900 dark:text-white mb-2">3.1 Registration</h3>
                <p>
                  To access certain features of the Service, you must register for an account. You agree to:
                </p>
                <ul className="list-disc pl-6 space-y-2">
                  <li>Provide accurate, current, and complete information during registration</li>
                  <li>Maintain and promptly update your account information</li>
                  <li>Maintain the security of your password and identification</li>
                  <li>Accept all responsibility for activities that occur under your account</li>
                  <li>Notify us immediately of any unauthorized use of your account</li>
                </ul>

                <h3 className="text-xl font-semibold text-slate-900 dark:text-white mb-2 mt-4">3.2 Account Termination</h3>
                <p>
                  We reserve the right to suspend or terminate your account at any time for violations of these Terms or for any other reason we deem necessary.
                </p>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">4. User Conduct</h2>
                <p>You agree not to:</p>
                <ul className="list-disc pl-6 space-y-2">
                  <li>Use the Service for any illegal purpose or in violation of any laws</li>
                  <li>Violate or infringe upon the rights of others</li>
                  <li>Transmit any harmful, offensive, or inappropriate content</li>
                  <li>Attempt to gain unauthorized access to the Service or its systems</li>
                  <li>Interfere with or disrupt the Service or servers</li>
                  <li>Use automated systems to access the Service without permission</li>
                  <li>Impersonate any person or entity</li>
                </ul>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">5. Intellectual Property</h2>
                <p>
                  The Service and its original content, features, and functionality are owned by BuildMate and are protected by international copyright, trademark, patent, trade secret, and other intellectual property laws.
                </p>
                <p>
                  You retain ownership of any content you create or upload to the Service. By uploading content, you grant us a license to use, display, and distribute your content as necessary to provide the Service.
                </p>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">6. Disclaimers</h2>
                <h3 className="text-xl font-semibold text-slate-900 dark:text-white mb-2">6.1 Service Availability</h3>
                <p>
                  The Service is provided "as is" and "as available" without warranties of any kind, either express or implied. We do not guarantee that the Service will be uninterrupted, secure, or error-free.
                </p>

                <h3 className="text-xl font-semibold text-slate-900 dark:text-white mb-2 mt-4">6.2 Component Information</h3>
                <p>
                  While we strive to provide accurate component information and compatibility data, we cannot guarantee the accuracy, completeness, or timeliness of all information. Component specifications and availability may change without notice.
                </p>

                <h3 className="text-xl font-semibold text-slate-900 dark:text-white mb-2 mt-4">6.3 Build Recommendations</h3>
                <p>
                  Our compatibility checks and recommendations are provided for informational purposes only. We are not responsible for any issues that may arise from following our recommendations. Always verify compatibility with component manufacturers before making purchases.
                </p>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">7. Limitation of Liability</h2>
                <p>
                  To the fullest extent permitted by law, BuildMate shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses resulting from your use of the Service.
                </p>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">8. Indemnification</h2>
                <p>
                  You agree to defend, indemnify, and hold harmless BuildMate and its officers, directors, employees, and agents from and against any claims, liabilities, damages, losses, and expenses, including reasonable attorney's fees, arising out of or in any way connected with your access to or use of the Service or your violation of these Terms.
                </p>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">9. Modifications to Terms</h2>
                <p>
                  We reserve the right to modify these Terms at any time. We will notify users of any material changes by posting the new Terms on this page and updating the "Last updated" date. Your continued use of the Service after such modifications constitutes acceptance of the updated Terms.
                </p>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">10. Termination</h2>
                <p>
                  We may terminate or suspend your account and access to the Service immediately, without prior notice or liability, for any reason, including if you breach the Terms. Upon termination, your right to use the Service will cease immediately.
                </p>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">11. Governing Law</h2>
                <p>
                  These Terms shall be governed by and construed in accordance with applicable laws, without regard to its conflict of law provisions. Any disputes arising from these Terms or the Service shall be resolved in the appropriate courts.
                </p>
              </section>

              <section>
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">12. Contact Information</h2>
                <p>
                  If you have any questions about these Terms of Service, please contact us through our support page or by email at support@buildmate.com.
                </p>
              </section>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}

